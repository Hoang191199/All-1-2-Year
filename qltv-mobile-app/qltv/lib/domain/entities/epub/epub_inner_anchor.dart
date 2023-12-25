import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';

class EpubInnerAnchor extends EpubConsistentInnerNavigation {
  final String anchor;

  EpubInnerAnchor(this.anchor);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'anchor',
    "anchor": anchor,
  };

  static EpubInnerAnchor fromJson(Map<String, dynamic> json) =>
      EpubInnerAnchor(json["anchor"]);

  List<Object?> get props => [anchor];
}