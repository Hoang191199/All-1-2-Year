import 'package:qltv/domain/entities/epub/epub_manifest_item.dart';

class EpubManifest {
  EpubManifest({
    this.items,
  });

  List<EpubManifestItem>? items;
}