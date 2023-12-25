class S3FinalInfo {
  S3FinalInfo({
    this.id,
    this.url,
    this.contentType,
    this.name,
    this.type,
  });

  String? id;
  String? url;
  String? contentType;
  String? name;
  String? type;

  factory S3FinalInfo.fromJson(Map<String, dynamic>? json) {
    return S3FinalInfo(
      id: json?['id'] == null ? "" : json?['id'] as String,
      url: json?['url'] == null ? "" : json?['url'] as String,
      contentType:
          json?['contentType'] == null ? "" : json?['contentType'] as String,
      name: json?['name'] == null ? "" : json?['name'] as String,
      type: json?['type'] == null ? "" : json?['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "contentType": contentType,
        "name": name,
        "type": type
      };
}
