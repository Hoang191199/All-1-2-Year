import 'package:qltv/domain/entities/epub/epub_byte_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_content_file.dart';
import 'package:qltv/domain/entities/epub/epub_text_content_file.dart';

class EpubContent {
  EpubContent({
    this.html,
    this.css,
    this.images,
    this.fonts,
    this.allFiles,
  });

  Map<String, EpubTextContentFile>? html;
  Map<String, EpubTextContentFile>? css;
  Map<String, EpubByteContentFile>? images;
  Map<String, EpubByteContentFile>? fonts;
  Map<String, EpubContentFile>? allFiles;
}