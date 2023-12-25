import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_inner_element.dart';
import 'package:qltv/domain/entities/epub/epub_inner_node.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_inner_text_node.dart';

abstract class EpubInnerNavigation {
  Map<String, dynamic> toJson();

  static EpubInnerNavigation fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'page':
        return EpubInnerPage.fromJson(json);
      case 'anchor':
        return EpubInnerAnchor.fromJson(json);
      case 'textNode':
        return EpubInnerTextNode.fromJson(json);
      case 'node':
        return EpubInnerNode.fromJson(json);
      case 'element':
        return EpubInnerElement.fromJson(json);
      default:
        throw Exception('Unknown inner navigation type');
    }
  }
}