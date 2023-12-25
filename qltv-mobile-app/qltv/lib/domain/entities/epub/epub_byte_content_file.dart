import 'package:qltv/domain/entities/epub/epub_content_file.dart';

class EpubByteContentFile extends EpubContentFile {
  EpubByteContentFile({
    this.content,
  });

  List<int>? content;
}