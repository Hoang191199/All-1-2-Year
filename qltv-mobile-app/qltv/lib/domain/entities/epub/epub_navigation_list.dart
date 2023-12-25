import 'package:qltv/domain/entities/epub/epub_navigation_label.dart';
import 'package:qltv/domain/entities/epub/epub_navigation_target.dart';

class EpubNavigationList {
  EpubNavigationList({
    this.id,
    this.classAtt,
    this.navigationLabels,
    this.navigationTargets,
  });

  String? id;
  String? classAtt;
  List<EpubNavigationLabel>? navigationLabels;
  List<EpubNavigationTarget>? navigationTargets;
}