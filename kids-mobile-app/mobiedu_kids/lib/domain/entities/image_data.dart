class ImageData {
  ImageData({this.source_file, this.file_name});

  String? source_file;
  String? file_name;

  factory ImageData.fromJson(Map<String, dynamic>? json) {
    return ImageData(
      source_file:
          json?['source_file'] == null ? null : json?['source_file'] as String,
      file_name:
          json?['file_name'] == null ? null : json?['file_name'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {'source_file': source_file, 'file_name': file_name};
}
