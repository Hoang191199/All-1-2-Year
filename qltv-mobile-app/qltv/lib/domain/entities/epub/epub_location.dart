import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_inner_navigation.dart';

class EpubLocation<PageType, Nav extends EpubInnerNavigation> {
  const EpubLocation(
    this.page,
    this.innerNav,
  );

  final PageType page;
  final Nav innerNav;

  // from EpubChapter
  static EpubLocation<String, EpubInnerAnchor> fromEpubChapter(EpubChapter chapter) => EpubLocation(
    chapter.contentFileName!,
    EpubInnerAnchor(chapter.anchor ?? ""),
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'innerNav': innerNav.toJson(),
  };

  static EpubLocation<PageType, Nav> fromJson<PageType, Nav extends EpubInnerNavigation>(Map<String, dynamic> json) {
    return EpubLocation<PageType, Nav>(
      json['page'],
      EpubInnerNavigation.fromJson(json['innerNav'] as Map<String, dynamic>) as Nav,
    );
  }

  List<Object?> get props => [page, innerNav];
}