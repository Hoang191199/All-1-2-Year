import 'package:qltv/domain/entities/epub/epub_navigation_content.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_label.dart';

class EpubNavigationTarget {
  EpubNavigationTarget({
    this.id,
    this.classAtt,
    this.value,
    this.playOrder,
    this.navigationLabels,
    this.content,
  });

  String? id;
  String? classAtt;
  String? value;
  String? playOrder;
  List<EpubNavigationLabel>? navigationLabels;
  EpubNavigationContent? content;
}