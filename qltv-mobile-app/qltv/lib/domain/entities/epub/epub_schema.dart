import 'package:qltv/domain/entities/epub/epub_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_package.dart';

class EpubSchema {
  EpubSchema({
    this.package,
    this.navigation,
    this.contentDirectoryPath,
  });

  EpubPackage? package;
  EpubNavigation? navigation;
  String? contentDirectoryPath;
}