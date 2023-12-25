import 'package:qltv/domain/entities/epub/epub_navigation_content.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_label.dart';

class EpubNavigationPoint {
  EpubNavigationPoint({
    this.id,
    this.classAtt,
    this.playOrder,
    this.navigationLabels,
    this.content,
    this.childNavigationPoints,
  });

  String? id;
  String? classAtt;
  String? playOrder;
  List<EpubNavigationLabel>? navigationLabels;
  EpubNavigationContent? content;
  List<EpubNavigationPoint>? childNavigationPoints;
}