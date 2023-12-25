class S3Info {
  S3Info({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory S3Info.fromJson(Map<String, dynamic>? json) {
    return S3Info(
      id: json?['idFile'] == null ? "" : json?['idFile'] as String,
      url: json?['uploadUrl'] == null ? "" : json?['uploadUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'idFile': id,
        'uploadUrl': url,
      };
}
