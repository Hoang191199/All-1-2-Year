import 'dart:typed_data';

class ImageMetaData {
  ImageMetaData({this.source_file, this.binary, this.file_name});

  String? source_file;
  Uint8List? binary;
  String? file_name;

  factory ImageMetaData.fromJson(Map<String, dynamic>? json) {
    return ImageMetaData(
      source_file:
          json?['source_file'] == null ? null : json?['source_file'] as String,
      file_name:
          json?['file_name'] == null ? null : json?['file_name'] as String,
      binary: json?['binary'] == null ? null : json?['binary'] as Uint8List,
    );
  }

  Map<String, dynamic> toJson() =>
      {'source_file': source_file, 'file_name': file_name, 'binary': binary};
}
