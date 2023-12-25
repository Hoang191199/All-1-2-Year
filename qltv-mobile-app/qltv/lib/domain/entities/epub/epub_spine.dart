import 'package:qltv/domain/entities/epub/epub_spine_item_ref.dart';

class EpubSpine {
  EpubSpine({
    this.tableOfContents,
    this.items,
    this.ltr,
  });

  String? tableOfContents;
  List<EpubSpineItemRef>? items;
  bool? ltr;
}