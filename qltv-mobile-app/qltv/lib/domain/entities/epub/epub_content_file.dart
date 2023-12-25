import 'package:qltv/domain/entities/epub/epub_content_type.dart';

class EpubContentFile {
  EpubContentFile({
    this.fileName,
    this.contentType,
    this.contentMimeType,
  });

  String? fileName;
  EpubContentType? contentType;
  String? contentMimeType;
}