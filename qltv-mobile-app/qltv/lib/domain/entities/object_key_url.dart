class ObjectKeyUrl {
  ObjectKeyUrl({
    this.objectKey,
    this.url,
  });

  String? objectKey;
  String? url;

  factory ObjectKeyUrl.fromJson(Map<String, dynamic>? json) {
    return ObjectKeyUrl(
      objectKey: json?["objectKey"] == null ? null : json?['objectKey'] as String,
      url: json?["url"] == null ? null : json?['url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'objectKey': objectKey,
    'url': url,
  };
}