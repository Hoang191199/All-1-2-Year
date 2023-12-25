import 'package:qltv/domain/entities/epub/epub_inner_text_node.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';

class EpubSearchResult {
  EpubSearchResult({
    required this.location,
    required this.nearbyText,
  });

  final EpubLocation<int, EpubInnerTextNode> location;
  final String nearbyText;
}