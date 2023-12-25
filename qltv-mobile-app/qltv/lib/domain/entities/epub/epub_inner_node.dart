import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';

class EpubInnerNode extends EpubConsistentInnerNavigation {
  final int nodeIndex;
  final int characterIndex;

  EpubInnerNode(this.nodeIndex, this.characterIndex);

  @override
  Map<String, dynamic> toJson() => {
    'type': 'node',
    "nodeIndex": nodeIndex,
    "characterIndex": characterIndex,
  };

  static EpubConsistentInnerNavigation fromJson(Map<String, dynamic> json) =>
    EpubInnerNode(json["nodeIndex"], json["characterIndex"]);

  List<Object?> get props => [nodeIndex, characterIndex];
}