import 'dart:math';

import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_manifest_item.dart';
import 'package:qltv/domain/entities/epub/epub_text_content_file.dart';

List<EpubTextContentFile> getFilesFromEpubSpine(EpubBook epubBook) {
  return getSpineItemsFromEpub(epubBook)
    .map((chapter) {
      if (epubBook.content?.allFiles?.containsKey(chapter?.href) != true) {
        return null;
      }
      return epubBook.content?.allFiles?[chapter?.href];
    })
    .whereType<EpubTextContentFile>()
    .toList();
}

List<EpubManifestItem?> getSpineItemsFromEpub(EpubBook epubBook) {
  return epubBook.schema?.package?.spine?.items
    ?.map((item) => epubBook.schema!.package!.manifest!.items?.where((element) => element.id == item.idRef).first)
    .toList() ?? [];
}

EpubChapter? linkSpineFileToChapter(EpubBook epubBook, int spineFileIndex, List<EpubContentFile>? spineFiles, List<String>? passedAnchors) {
  final allChapters = epubBook.chapters
    ?.map((chapter) => getAllSubEpubChapters(chapter)..insert(0, chapter))
    .expand((subChapters) => subChapters)
    .toList() ?? [];
  spineFiles = spineFiles ?? getFilesFromEpubSpine(epubBook);
  final chaptersAsSpineFilesIndexes = allChapters
    .map((chapter) => spineFiles?.indexWhere((file) => file.fileName == Uri.decodeFull(chapter.contentFileName ?? ''))).toList();

  final mapped = {
    for (var entry in chaptersAsSpineFilesIndexes.asMap().entries)
      entry.key: entry.value
  };

  final ordered = (mapped.keys.toList()..sort((a, b) => b.compareTo(a)));
  final currentChapters = ordered
      .where((key) => mapped[key]! == spineFileIndex)
      .map((key) => allChapters[key])
      .toList();

  if (currentChapters.isEmpty) {
    final latestChapterPassed = allChapters[
        ordered.firstWhereOrNull((key) => mapped[key]! <= spineFileIndex) ?? 0];
    return latestChapterPassed;
  } else if (passedAnchors == null) {
    return currentChapters.first;
  } else {
    final currentChaptersValues = currentChapters
        .map(
          (subChapter) => subChapter.anchor == null
              ? 0
              : passedAnchors.indexOf(subChapter.anchor!),
        )
        .toList();

    final highestIndex = currentChaptersValues.indexOf(
      currentChaptersValues.reduce(max),
    );

    final currentChapter = currentChapters[highestIndex];
    return currentChapter;
  }
}

List<EpubChapter> getAllSubEpubChapters(EpubChapter chapter) {
  final List<EpubChapter> chapters = [];
  chapters.add(chapter);
  chapter.subChapters?.forEach((subChapter) {
    chapters.addAll(getAllSubEpubChapters(subChapter));
  });
  return chapters;
}

List<int> getWordsPerSpineItem(EpubBook epubBook) {
  return getFilesFromEpubSpine(epubBook).map((file) {
    if (file.content != null) {
      return RegExp("[\\w-]+").allMatches(parse(file.content!).body!.text).length;
    }
    return 0;
  }).toList();
}