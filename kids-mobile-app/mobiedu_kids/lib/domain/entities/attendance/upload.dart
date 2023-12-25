class Upload {
  Upload({
    this.source_file

  });
  String ? source_file;

  factory Upload.fromJson(Map<String, dynamic>? json) {
    return Upload(
      source_file: json?["source_file"] == null ? null : json?['source_file'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'source_file': source_file
  };
}