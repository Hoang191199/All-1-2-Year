import 'package:qltv/domain/entities/epub/epub_navigation_content.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_label.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_page_target_type.dart';

class EpubNavigationPageTarget {
  EpubNavigationPageTarget({
    this.id,
    this.value,
    this.type,
    this.classAtt,
    this.playOrder,
    this.navigationLabels,
    this.content,
  });

  String? id;
  String? value;
  EpubNavigationPageTargetType? type;
  String? classAtt;
  String? playOrder;
  List<EpubNavigationLabel>? navigationLabels;
  EpubNavigationContent? content;
}