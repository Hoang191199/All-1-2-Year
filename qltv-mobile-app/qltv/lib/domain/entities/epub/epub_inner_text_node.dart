import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';

class EpubInnerTextNode extends EpubConsistentInnerNavigation {
  final int textNodeIndex;
  final int characterIndex;

  EpubInnerTextNode(this.textNodeIndex, this.characterIndex);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'textNode',
    "textNodeIndex": textNodeIndex,
    "characterIndex": characterIndex,
  };

  static EpubConsistentInnerNavigation fromJson(Map<String, dynamic> json) =>
    EpubInnerTextNode(json["textNodeIndex"], json["characterIndex"]);

  List<Object?> get props => [textNodeIndex, characterIndex];
}