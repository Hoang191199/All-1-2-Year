import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';

class EpubInnerElement extends EpubConsistentInnerNavigation {
  final int elementIndex;

  EpubInnerElement(this.elementIndex);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'element',
    "elementIndex": elementIndex,
  };

  static EpubConsistentInnerNavigation fromJson(Map<String, dynamic> json) =>
    EpubInnerElement(json["elementIndex"]);

  List<Object?> get props => [elementIndex];
}