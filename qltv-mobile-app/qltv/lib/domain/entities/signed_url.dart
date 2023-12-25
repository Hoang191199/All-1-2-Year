class SignedUrl {
  SignedUrl({this.objectKey, this.fileName, this.url});

  String? objectKey;
  String? fileName;
  String? url;

  factory SignedUrl.fromJson(Map<String, dynamic>? json) {
    return SignedUrl(
      objectKey:
          json?["objectKey"] == null ? null : json?['objectKey'] as String,
      fileName: json?["fileName"] == null ? null : json?['fileName'] as String,
      url: json?["url"] == null ? null : json?['url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'objectKey': objectKey,
        'fileName': fileName,
        'url': url,
      };
}
