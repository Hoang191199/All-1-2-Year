import 'package:qltv/domain/entities/epub/epub_guide.dart';
import 'package:qltv/domain/entities/epub/epub_manifest.dart';
import 'package:qltv/domain/entities/epub/epub_metadata.dart';
import 'package:qltv/domain/entities/epub/epub_spine.dart';
import 'package:qltv/domain/entities/epub/epub_version.dart';

class EpubPackage {
  EpubPackage({
    this.version,
    this.metadata,
    this.manifest,
    this.spine,
    this.guide,
  });

  EpubVersion? version;
  EpubMetadata? metadata;
  EpubManifest? manifest;
  EpubSpine? spine;
  EpubGuide? guide;
}