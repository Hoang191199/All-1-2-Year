import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:html/dom.dart' as dom;
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/services/epub_server_files.dart';
import 'package:qltv/domain/entities/bookcase_progress.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_byte_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_content.dart';
import 'package:qltv/domain/entities/epub/epub_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_content_type.dart';
import 'package:qltv/domain/entities/epub/epub_guide.dart';
import 'package:qltv/domain/entities/epub/epub_guide_reference.dart';
import 'package:qltv/domain/entities/epub/epub_inner_text_node.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_manifest.dart';
import 'package:qltv/domain/entities/epub/epub_manifest_item.dart';
import 'package:qltv/domain/entities/epub/epub_metadata.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_contributor.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_creator.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_date.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_identifier.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_meta.dart';
import 'package:qltv/domain/entities/epub/epub_package.dart';
import 'package:qltv/domain/entities/epub/epub_schema.dart';
import 'package:qltv/domain/entities/epub/epub_search_result.dart';
import 'package:qltv/domain/entities/epub/epub_spine.dart';
import 'package:qltv/domain/entities/epub/epub_spine_item_ref.dart';
import 'package:qltv/domain/entities/epub/epub_text_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_version.dart';
import 'package:qltv/presentation/controllers/publication_digital/book_player_render_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:qltv/presentation/controllers/s3/s3_binding.dart';
import 'package:qltv/presentation/controllers/s3/s3_controller.dart';
import 'package:xml/xml.dart';
import 'package:image/image.dart' as images;

class EpubController {
  EpubController(
    this.filePathObjectKey,
    this.bookcaseProgress,
  );

  final String filePathObjectKey;
  final BookcaseProgress? bookcaseProgress;

  var filePath = '';
  var fileDirPath = '';
  var rootOpfFilePath = '';
  EpubBook? epubBook;
  EpubServerFiles? epubServerFiles;
  BookPlayerRenderController? bookController;
  // var wordsPerPage = 200.0;

  initialize() async {
    filePath = '';
    fileDirPath = '';
    await download();
    await readContainerXmlFile();
    await readOpfFile();

    epubServerFiles = EpubServerFiles(epubBook);
    await epubServerFiles?.initialize();
  }

  close() {
    epubServerFiles?.close();
  }

  download() async {
    if (await Permission.storage.isGranted) {
      await Permission.storage.request();
      await downloadFile();
    } else {
      await downloadFile();
    }
  }

  readContainerXmlFile() {
    final fileXml = File('$fileDirPath/META-INF/container.xml');
    final document = XmlDocument.parse(fileXml.readAsStringSync());
    final rootFilePath = document.findAllElements('rootfile').first.getAttribute('full-path');
    rootOpfFilePath = rootFilePath ?? '';
  }

  readOpfFile() async {
    var resultEpubBook = EpubBook();

    final fileXml = File('$fileDirPath/$rootOpfFilePath');
    final document = XmlDocument.parse(fileXml.readAsStringSync());

    var epubSchema = EpubSchema();
    epubSchema.contentDirectoryPath = getPathDirRoot();
    var epubPackage = EpubPackage();
    final packageElement = document.findAllElements('package').firstWhere((XmlElement? element) => element != null);
    var epubVersionValue = packageElement.getAttribute('version');
    if (epubVersionValue == '2.0') {
      epubPackage.version = EpubVersion.Epub2;
    } else if (epubVersionValue == '3.0') {
      epubPackage.version = EpubVersion.Epub3;
    }
    var metadataElement = packageElement
      .findElements('metadata')
      .cast<XmlElement?>()
      .firstWhere((XmlElement? element) => element != null);
    var metadata = readMetadata(metadataElement!, epubPackage.version);
    epubPackage.metadata = metadata;
    var manifestElement = packageElement
      .findElements('manifest')
      .cast<XmlElement?>()
      .firstWhere((XmlElement? element) => element != null);
    var manifest = readManifest(manifestElement!);
    epubPackage.manifest = manifest;
    var spineElement = packageElement
      .findElements('spine')
      .cast<XmlElement?>()
      .firstWhere((XmlElement? element) => element != null);
    var spine = readSpine(spineElement!);
    epubPackage.spine = spine;
    var guideElements = packageElement
        .findElements('guide')
        .where((XmlElement? element) => element != null);
    if (guideElements.isNotEmpty) {
      var guide = readGuide(guideElements.first);
      epubPackage.guide = guide;
    }

    epubSchema.package = epubPackage;

    resultEpubBook.schema = epubSchema;

    final titleElements = document.findAllElements('dc:title');
    resultEpubBook.title = titleElements.first.innerText;

    final authorElements = document.findAllElements('dc:creator');
    resultEpubBook.author = authorElements.first.innerText;
    List<String> authorList = [];
    for (var author in authorElements) {
      authorList.add(author.innerText);
    }
    resultEpubBook.authorList = authorList;

    final languageElements = document.findAllElements('dc:language');
    resultEpubBook.language = languageElements.first.innerText;

    final itemElements = document.findAllElements('item');
    var tocNcxNavElements = itemElements.where((element) => element.getAttribute('id') == 'toc');
    if (tocNcxNavElements.isEmpty) {
      tocNcxNavElements = itemElements.where((element) => element.getAttribute('id') == 'ncx');
      if (tocNcxNavElements.isEmpty) {
        tocNcxNavElements = itemElements.where((element) => element.getAttribute('id') == 'nav');
      }
    }
    final tocNcxNavElement = tocNcxNavElements.first;
    String tocFilePath = getPathDirRoot().isEmpty ? '$fileDirPath/${tocNcxNavElement.getAttribute('href')}' : '$fileDirPath/${getPathDirRoot()}/${tocNcxNavElement.getAttribute('href')}';
    List<EpubChapter> chapterList = [];
    File tocfile = File(tocFilePath);
    final tocXml = XmlDocument.parse(tocfile.readAsStringSync());
    if (tocNcxNavElement.getAttribute('href')?.contains('ncx') ?? false) {
      final navMapElements = tocXml.findAllElements('navMap');
      final navPointElements = navMapElements.first.childElements;
      await getChapterByNavPoint(chapterList, navPointElements, 0);
    } else if (tocNcxNavElement.getAttribute('href')?.contains('html') ?? false) {
      final firstOlElement = tocXml.findAllElements('ol').first;
      await getChapterByOl(chapterList, firstOlElement, 0);
    }
    resultEpubBook.chapters = chapterList;

    final coverImageElements = itemElements.where((element) => (element.getAttribute('id') == 'cover-image' || element.getAttribute('properties') == 'cover-image') && element.getAttribute('media-type') == MediaType.image_jpeg);
    if (coverImageElements.isNotEmpty) {
      String coverImageFilePath = getPathDirRoot().isEmpty ? '$fileDirPath/${coverImageElements.first.getAttribute('href')}' : '$fileDirPath/${getPathDirRoot()}/${coverImageElements.first.getAttribute('href')}';
      File coverImageFile = File(coverImageFilePath);
      Uint8List coverImagebytes = await coverImageFile.readAsBytes();
      resultEpubBook.coverImage = images.decodeImage(coverImagebytes);
    }

    var epubContent = EpubContent();
    epubContent.html = <String, EpubTextContentFile>{};
    epubContent.css = <String, EpubTextContentFile>{};
    epubContent.images = <String, EpubByteContentFile>{};
    epubContent.fonts = <String, EpubByteContentFile>{};
    epubContent.allFiles = <String, EpubContentFile>{};
    for (var itemElement in itemElements) {
      var fileName = itemElement.getAttribute('href');
      var contentMimeType = itemElement.getAttribute('media-type') ?? '';
      var contentType = getContentTypeByContentMimeType(contentMimeType);
      String contentFilePath = getPathDirRoot().isEmpty ? '$fileDirPath/$fileName' : '$fileDirPath/${getPathDirRoot()}/$fileName';
      File contentfile = File(Uri.decodeFull(contentFilePath));
      switch (contentType) {
        case EpubContentType.XHTML_1_1:
        case EpubContentType.CSS:
        case EpubContentType.OEB1_DOCUMENT:
        case EpubContentType.OEB1_CSS:
        case EpubContentType.XML:
        case EpubContentType.DTBOOK:
        case EpubContentType.DTBOOK_NCX:
          var epubTextContentFile = EpubTextContentFile();
          var contents = await contentfile.readAsString();
          {
            epubTextContentFile.fileName = Uri.decodeFull(fileName!);
            epubTextContentFile.contentMimeType = contentMimeType;
            epubTextContentFile.contentType = contentType;
            epubTextContentFile.content = contents;
          }
          switch (contentType) {
            case EpubContentType.XHTML_1_1:
              epubContent.html![fileName] = epubTextContentFile;
              break;
            case EpubContentType.CSS:
              epubContent.css![fileName] = epubTextContentFile;
              break;
            case EpubContentType.DTBOOK:
            case EpubContentType.DTBOOK_NCX:
            case EpubContentType.OEB1_DOCUMENT:
            case EpubContentType.XML:
            case EpubContentType.OEB1_CSS:
            case EpubContentType.IMAGE_GIF:
            case EpubContentType.IMAGE_JPEG:
            case EpubContentType.IMAGE_PNG:
            case EpubContentType.IMAGE_SVG:
            case EpubContentType.FONT_TRUETYPE:
            case EpubContentType.FONT_OPENTYPE:
            case EpubContentType.OTHER:
              break;
          }
          epubContent.allFiles![fileName] = epubTextContentFile;
          break;
        default:
          var epubByteContentFile = EpubByteContentFile();
          final contentBytes = contentfile.readAsBytesSync();
          {
            epubByteContentFile.fileName = Uri.decodeFull(fileName!);
            epubByteContentFile.contentMimeType = contentMimeType;
            epubByteContentFile.contentType = contentType;
            epubByteContentFile.content = contentBytes;
          }
          switch (contentType) {
            case EpubContentType.IMAGE_GIF:
            case EpubContentType.IMAGE_JPEG:
            case EpubContentType.IMAGE_PNG:
            case EpubContentType.IMAGE_SVG:
              epubContent.images![fileName] = epubByteContentFile;
              break;
            case EpubContentType.FONT_TRUETYPE:
            case EpubContentType.FONT_OPENTYPE:
              epubContent.fonts![fileName] = epubByteContentFile;
              break;
            case EpubContentType.CSS:
            case EpubContentType.XHTML_1_1:
            case EpubContentType.DTBOOK:
            case EpubContentType.DTBOOK_NCX:
            case EpubContentType.OEB1_DOCUMENT:
            case EpubContentType.XML:
            case EpubContentType.OEB1_CSS:
            case EpubContentType.OTHER:
              break;
          }
          epubContent.allFiles![fileName] = epubByteContentFile;
          break;
      }
    }
    resultEpubBook.content = epubContent;

    epubBook = resultEpubBook;

    epubBook?.wordsPerSpineItem = getWordsPerSpineItem(resultEpubBook);
  }

  Future<void> getChapterByNavPoint(List<EpubChapter> chapterList, Iterable<XmlElement> navPointElements, int level) async {
    for (var navPoint in navPointElements) {
      final navPointChildElements = navPoint.childElements;
      var chapterSrc = navPointChildElements.where((element) => element.localName == 'content').first.getAttribute('src') ?? '';
      var hrefContentFile = '';
      var anchor = '';
      if (chapterSrc.isNotEmpty) {
        if (chapterSrc.contains('../')) {
          chapterSrc = chapterSrc.split('../').last;
        }
        if (chapterSrc.contains('./')) {
          chapterSrc = chapterSrc.split('./').last;
        }
        hrefContentFile = chapterSrc;
        if (chapterSrc.contains('#')) {
          hrefContentFile = chapterSrc.split('#')[0];
          anchor = chapterSrc.split('#')[1];
        }
      }
      String contentFilePath = getPathDirRoot().isEmpty ? '$fileDirPath/$hrefContentFile' : '$fileDirPath/${getPathDirRoot()}/$hrefContentFile';
      File contentfile = File(Uri.decodeFull(contentFilePath));
      var contents = await contentfile.readAsString();
      final epubChapter = EpubChapter(
        title: navPointChildElements.where((element) => element.localName == 'navLabel').first.firstElementChild?.innerText,
        contentFileName: hrefContentFile,
        anchor: anchor.isNotEmpty ? anchor : null,
        htmlContent: contents,
        level: level
      );
      chapterList.add(epubChapter);
      final navPointSubElements = navPointChildElements.where((element) => element.localName == 'navPoint');
      if (navPointSubElements.isNotEmpty) {
        await getChapterByNavPoint(chapterList, navPointSubElements, level + 1);
      }
    }
  }

  Future<void> getChapterByOl(List<EpubChapter> chapterList, XmlElement olElement, int level) async {
    final liElements = olElement.childElements;
    for (var li in liElements) {
      final childElements = li.childElements;
      final aElement = childElements.firstWhere((element) => element.localName == 'a');
      var hrefContent = aElement.getAttribute('href') ?? '';
      var hrefContentFile = '';
      var anchor = '';
      if (hrefContent.isNotEmpty) {
        if (hrefContent.contains('../')) {
          hrefContent = hrefContent.split('../').last;
        }
        if (hrefContent.contains('./')) {
          hrefContent = hrefContent.split('./').last;
        }
        hrefContentFile = hrefContent;
        if (hrefContent.contains('#')) {
          hrefContentFile = hrefContent.split('#')[0];
          anchor = hrefContent.split('#')[1];
        }
      }
      String contentFilePath = getPathDirRoot().isEmpty ? '$fileDirPath/$hrefContentFile' : '$fileDirPath/${getPathDirRoot()}/$hrefContentFile';
      File contentfile = File(Uri.decodeFull(contentFilePath));
      var contents = await contentfile.readAsString();
      var epubChapter = EpubChapter(
        title: aElement.innerText,
        contentFileName: hrefContentFile,
        anchor: anchor.isNotEmpty ? anchor : null,
        htmlContent: contents,
        level: level
      );
      chapterList.add(epubChapter);
      final olElements = childElements.where((element) => element.localName == 'ol');
      if (olElements.isNotEmpty) {
        await getChapterByOl(chapterList, olElements.first, level + 1);
      }
    }
  }

  downloadFile() async {
    Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${getFileNameFromFilePathObjectKey()}';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      S3Binding().dependencies();
      final s3Controller = Get.find<S3Controller>();
      await s3Controller.preSignedGetUrl(filePathObjectKey);
      if (!(s3Controller.responseData.value?.error ?? false)) {
        Dio dio = Dio();
        await dio.download(
          s3Controller.s3Data.value?.url ?? '',
          path,
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {
          },
        ).whenComplete(() {
          filePath = path;

          final inputStream = InputFileStream(filePath);
          final archive = ZipDecoder().decodeBuffer(inputStream);
          final dirName = getFileNameFromFilePathObjectKey().toString().split('.')[0];
          fileDirPath = '${appDocDir.path}/$dirName';
          for (final file in archive.files) {
            if (file.isFile && file.crc32 == 0) {
              file.isFile = false;
            }
          }
          extractArchiveToDisk(archive, fileDirPath);
        });
      }
    } else {
      filePath = path;
      final dirName = getFileNameFromFilePathObjectKey().toString().split('.')[0];
      fileDirPath = '${appDocDir.path}/$dirName';
    }
  }

  getFileNameFromFilePathObjectKey() {
    final arr = filePathObjectKey.split('/');
    final fileName = arr.last;
    return fileName;
  }

  String getPathDirRoot() {
    var pathTemp = '';
    if (rootOpfFilePath.contains('/')) {
      pathTemp = rootOpfFilePath.substring(0, rootOpfFilePath.lastIndexOf('/'));
    }
    return pathTemp;
  }

  EpubMetadata readMetadata(XmlElement metadataElement, EpubVersion? epubVersion) {
    var epubMetadata = EpubMetadata();
    epubMetadata.titles = <String>[];
    epubMetadata.creators = <EpubMetadataCreator>[];
    epubMetadata.subjects = <String>[];
    epubMetadata.publishers = <String>[];
    epubMetadata.contributors = <EpubMetadataContributor>[];
    epubMetadata.dates = <EpubMetadataDate>[];
    epubMetadata.types = <String>[];
    epubMetadata.formats = <String>[];
    epubMetadata.identifiers = <EpubMetadataIdentifier>[];
    epubMetadata.sources = <String>[];
    epubMetadata.languages = <String>[];
    epubMetadata.relations = <String>[];
    epubMetadata.coverages = <String>[];
    epubMetadata.rights = <String>[];
    epubMetadata.metaItems = <EpubMetadataMeta>[];
    metadataElement.children
      .whereType<XmlElement>()
      .forEach((XmlElement metadataItemElement) {
        var innerText = metadataItemElement.text;
        switch (metadataItemElement.name.local.toLowerCase()) {
          case 'title':
            epubMetadata.titles!.add(innerText);
            break;
          case 'creator':
            var creator = readMetadataCreator(metadataItemElement);
            epubMetadata.creators!.add(creator);
            break;
          case 'subject':
            epubMetadata.subjects!.add(innerText);
            break;
          case 'description':
            epubMetadata.description = innerText;
            break;
          case 'publisher':
            epubMetadata.publishers!.add(innerText);
            break;
          case 'contributor':
            var contributor = readMetadataContributor(metadataItemElement);
            epubMetadata.contributors!.add(contributor);
            break;
          case 'date':
            var date = readMetadataDate(metadataItemElement);
            epubMetadata.dates!.add(date);
            break;
          case 'type':
            epubMetadata.types!.add(innerText);
            break;
          case 'format':
            epubMetadata.formats!.add(innerText);
            break;
          case 'identifier':
            var identifier = readMetadataIdentifier(metadataItemElement);
            epubMetadata.identifiers!.add(identifier);
            break;
          case 'source':
            epubMetadata.sources!.add(innerText);
            break;
          case 'language':
            epubMetadata.languages!.add(innerText);
            break;
          case 'relation':
            epubMetadata.relations!.add(innerText);
            break;
          case 'coverage':
            epubMetadata.coverages!.add(innerText);
            break;
          case 'rights':
            epubMetadata.rights!.add(innerText);
            break;
          case 'meta':
            if (epubVersion == EpubVersion.Epub2) {
              var meta = readMetadataMetaVersion2(metadataItemElement);
              epubMetadata.metaItems!.add(meta);
            } else if (epubVersion == EpubVersion.Epub3) {
              var meta = readMetadataMetaVersion3(metadataItemElement);
              epubMetadata.metaItems!.add(meta);
            }
            break;
        }
      }
    );
    return epubMetadata;
  }

  EpubMetadataCreator readMetadataCreator(XmlElement metadataCreatorElement) {
    var epubMetadataCreator = EpubMetadataCreator();
    for (var metadataCreatorNodeAttribute in metadataCreatorElement.attributes) {
      var attributeValue = metadataCreatorNodeAttribute.value;
      switch (metadataCreatorNodeAttribute.name.local.toLowerCase()) {
        case 'role':
          epubMetadataCreator.role = attributeValue;
          break;
        case 'file-as':
          epubMetadataCreator.fileAs = attributeValue;
          break;
      }
    }
    epubMetadataCreator.creator = metadataCreatorElement.text;
    return epubMetadataCreator;
  }

  EpubMetadataContributor readMetadataContributor(XmlElement metadataContributorElement) {
    var epubMetadataContributor = EpubMetadataContributor();
    for (var metadataContributorNodeAttribute in metadataContributorElement.attributes) {
      var attributeValue = metadataContributorNodeAttribute.value;
      switch (metadataContributorNodeAttribute.name.local.toLowerCase()) {
        case 'role':
          epubMetadataContributor.role = attributeValue;
          break;
        case 'file-as':
          epubMetadataContributor.fileAs = attributeValue;
          break;
      }
    }
    epubMetadataContributor.contributor = metadataContributorElement.text;
    return epubMetadataContributor;
  }

  EpubMetadataDate readMetadataDate(XmlElement metadataDateElement) {
    var epubMetadataDate = EpubMetadataDate();
    var eventAttribute = metadataDateElement.getAttribute('event', namespace: metadataDateElement.name.namespaceUri);
    if (eventAttribute != null && eventAttribute.isNotEmpty) {
      epubMetadataDate.event = eventAttribute;
    }
    epubMetadataDate.date = metadataDateElement.text;
    return epubMetadataDate;
  }

  EpubMetadataIdentifier readMetadataIdentifier(XmlElement metadataIdentifierElement) {
    var epubMetadataIdentifier = EpubMetadataIdentifier();
    for (var metadataIdentifierNodeAttribute in metadataIdentifierElement.attributes) {
      var attributeValue = metadataIdentifierNodeAttribute.value;
      switch (metadataIdentifierNodeAttribute.name.local.toLowerCase()) {
        case 'id':
          epubMetadataIdentifier.id = attributeValue;
          break;
        case 'scheme':
          epubMetadataIdentifier.scheme = attributeValue;
          break;
      }
    }
    epubMetadataIdentifier.identifier = metadataIdentifierElement.text;
    return epubMetadataIdentifier;
  }

  EpubMetadataMeta readMetadataMetaVersion2(XmlElement metadataMetaElement) {
    var epubMetadataMeta = EpubMetadataMeta();
    for (var metadataMetaNodeAttribute in metadataMetaElement.attributes) {
      var attributeValue = metadataMetaNodeAttribute.value;
      switch (metadataMetaNodeAttribute.name.local.toLowerCase()) {
        case 'name':
          epubMetadataMeta.name = attributeValue;
          break;
        case 'content':
          epubMetadataMeta.content = attributeValue;
          break;
      }
    }
    return epubMetadataMeta;
  }

  EpubMetadataMeta readMetadataMetaVersion3(XmlElement metadataMetaElement) {
    var epubMetadataMeta = EpubMetadataMeta();
    epubMetadataMeta.attributes = {};
    for (var metadataMetaNodeAttribute in metadataMetaElement.attributes) {
      var attributeValue = metadataMetaNodeAttribute.value;
      epubMetadataMeta.attributes![metadataMetaNodeAttribute.name.local.toLowerCase()] = attributeValue;
      switch (metadataMetaNodeAttribute.name.local.toLowerCase()) {
        case 'id':
          epubMetadataMeta.id = attributeValue;
          break;
        case 'refines':
          epubMetadataMeta.refines = attributeValue;
          break;
        case 'property':
          epubMetadataMeta.property = attributeValue;
          break;
        case 'scheme':
          epubMetadataMeta.scheme = attributeValue;
          break;
        case 'content':
          epubMetadataMeta.content = attributeValue;
          break;
        case 'name':
          epubMetadataMeta.name = attributeValue;
          break;
      }
    }
    epubMetadataMeta.content = epubMetadataMeta.content ?? metadataMetaElement.text;
    return epubMetadataMeta;
  }

  EpubManifest readManifest(XmlElement manifestElement) {
    var epubManifest = EpubManifest();
    epubManifest.items = <EpubManifestItem>[];
    manifestElement.children
      .whereType<XmlElement>()
      .forEach((XmlElement manifestItemElement) {
        if (manifestItemElement.name.local.toLowerCase() == 'item') {
          var manifestItem = EpubManifestItem();
          for (var manifestItemNodeAttribute in manifestItemElement.attributes) {
            var attributeValue = manifestItemNodeAttribute.value;
            switch (manifestItemNodeAttribute.name.local.toLowerCase()) {
              case 'id':
                manifestItem.id = attributeValue;
                break;
              case 'href':
                manifestItem.href = attributeValue;
                break;
              case 'media-type':
                manifestItem.mediaType = attributeValue;
                break;
              case 'media-overlay':
                manifestItem.mediaOverlay = attributeValue;
                break;
              case 'required-namespace':
                manifestItem.requiredNamespace = attributeValue;
                break;
              case 'required-modules':
                manifestItem.requiredModules = attributeValue;
                break;
              case 'fallback':
                manifestItem.fallback = attributeValue;
                break;
              case 'fallback-style':
                manifestItem.fallbackStyle = attributeValue;
                break;
              case 'properties':
                manifestItem.properties = attributeValue;
                break;
            }
          }

          if (manifestItem.id == null || manifestItem.id!.isEmpty) {
            throw Exception('Incorrect EPUB manifest: item ID is missing');
          }
          if (manifestItem.href == null || manifestItem.href!.isEmpty) {
            throw Exception('Incorrect EPUB manifest: item href is missing');
          }
          if (manifestItem.mediaType == null || manifestItem.mediaType!.isEmpty) {
            throw Exception('Incorrect EPUB manifest: item media type is missing');
          }
          epubManifest.items!.add(manifestItem);
        }
      }
    );
    return epubManifest;
  }

  EpubSpine readSpine(XmlElement spineElement) {
    var epubSpine = EpubSpine();
    epubSpine.items = <EpubSpineItemRef>[];
    var tocAttribute = spineElement.getAttribute('toc');
    epubSpine.tableOfContents = tocAttribute;
    var pageProgression = spineElement.getAttribute('page-progression-direction');
    epubSpine.ltr = ((pageProgression == null) || pageProgression.toLowerCase() == 'ltr');
    spineElement.children
      .whereType<XmlElement>()
      .forEach((XmlElement spineItemElement) {
        if (spineItemElement.name.local.toLowerCase() == 'itemref') {
          var spineItemRef = EpubSpineItemRef();
          var idRefAttribute = spineItemElement.getAttribute('idref');
          if (idRefAttribute == null || idRefAttribute.isEmpty) {
            throw Exception('Incorrect EPUB spine: item ID ref is missing');
          }
          spineItemRef.idRef = idRefAttribute;
          var linearAttribute = spineItemElement.getAttribute('linear');
          spineItemRef.isLinear =
              linearAttribute == null || (linearAttribute.toLowerCase() == 'no');
          epubSpine.items!.add(spineItemRef);
        }
      }
    );
    return epubSpine;
  }

  EpubGuide readGuide(XmlElement guideElement) {
    var epubGuide = EpubGuide();
    epubGuide.items = <EpubGuideReference>[];
    guideElement.children
      .whereType<XmlElement>()
      .forEach((XmlElement guideReferenceElement) {
        if (guideReferenceElement.name.local.toLowerCase() == 'reference') {
          var guideReference = EpubGuideReference();
          for (var guideReferenceNodeAttribute in guideReferenceElement.attributes) {
            var attributeValue = guideReferenceNodeAttribute.value;
            switch (guideReferenceNodeAttribute.name.local.toLowerCase()) {
              case 'type':
                guideReference.type = attributeValue;
                break;
              case 'title':
                guideReference.title = attributeValue;
                break;
              case 'href':
                guideReference.href = attributeValue;
                break;
            }
          }
          if (guideReference.type == null || guideReference.type!.isEmpty) {
            throw Exception('Incorrect EPUB guide: item type is missing');
          }
          if (guideReference.href == null || guideReference.href!.isEmpty) {
            throw Exception('Incorrect EPUB guide: item href is missing');
          }
          epubGuide.items!.add(guideReference);
        }
      }
    );
    return epubGuide;
  }

  List<EpubSearchResult> getListEpubSearchResult(String searchStr) {
    List<EpubContentFile> spineFiles = getFilesFromEpubSpine(epubBook ?? EpubBook());
    var data = spineFiles.asMap().entries.map((entry) {
      final index = entry.key;
      final file = entry.value;

      final spineFileSearchResults = <EpubSearchResult>[];

      if (file is! EpubTextContentFile) {
        return spineFileSearchResults;
      }

      final document = parse(file.content);
      final topElement = document.getElementsByTagName("html").first;

      final textNodes = nodesUnder(topElement, nodeType: dom.Node.TEXT_NODE, leaveHoles: false);

      for (var entry in textNodes.asMap().entries) {
        final textNodeIndex = entry.key;
        final textNode = entry.value;

        if (textNode?.text == null) {
          continue;
        }
        
        try {
          final matches = RegExp(searchStr).allMatches(textNode!.text!);
          for (var match in matches) {
            spineFileSearchResults.add(EpubSearchResult(
              location: EpubLocation(
                index, 
                EpubInnerTextNode(textNodeIndex - 2, match.start)
              ),
              nearbyText: textNode.text!.substring(
                max(match.start - 20, 0),
                min(match.end + 20, textNode.text!.length),
              ),
            ));
          }
        } catch (error) {
          return spineFileSearchResults;
        }
      }

      return spineFileSearchResults;
    })
    .expand((i) => i)
    .toList();

    return data;
  }

  List<dom.Node?> nodesUnder(dom.Node node, {int nodeType = -1, bool leaveHoles = false}) {
    var all = <dom.Node?>[];
    for (var node in node.nodes) {
      if (nodeType == -1 || node.nodeType == nodeType) {
        all.add(node);
      } else if (leaveHoles) {
        all.add(null);
      }
      all += nodesUnder(
        node,
        nodeType: nodeType,
        leaveHoles: leaveHoles,
      );
    }
    return all;
  }
}