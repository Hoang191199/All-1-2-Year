import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';

class EpubChapterItem {
  EpubChapterItem({
    required this.title,
    required this.depth,
    required this.location,
    required this.original,
    required this.level,
  });

  String title;
  int depth;
  EpubLocation<String, EpubInnerAnchor> location;
  EpubChapter original;
  int level;

  factory EpubChapterItem.fromEpubChapter(EpubChapter chapter, int depth) {
    return EpubChapterItem(
      title: chapter.title ?? "Unnamed chapter",
      depth: depth,
      location: EpubLocation.fromEpubChapter(chapter),
      original: chapter,
      level: chapter.level ?? 0,
    );
  }
}