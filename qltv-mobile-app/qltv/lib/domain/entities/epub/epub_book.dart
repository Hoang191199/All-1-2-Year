import 'package:image/image.dart';
import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_content.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_schema.dart';

class EpubBook {
  EpubBook({
    this.title,
    this.author,
    this.authorList,
    this.language,
    this.schema,
    this.content,
    this.coverImage,
    this.chapters,
    this.wordsPerSpineItem,
    this.consistentLocation,
    this.progressSpine,
  });

  String? title;
  String? author;
  List<String>? authorList;
  String? language;
  EpubSchema? schema;
  EpubContent? content;
  Image? coverImage;
  List<EpubChapter>? chapters;
  List<int>? wordsPerSpineItem;
  EpubLocation<int, EpubConsistentInnerNavigation>? consistentLocation;
  double? progressSpine = 0.0;
}