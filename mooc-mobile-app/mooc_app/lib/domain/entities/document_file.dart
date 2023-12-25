class DocumentFile {
  DocumentFile({
    this.id,
    this.name,
    this.type,
    this.contentType,
    this.url,
  });

  String? id;
  String? name;
  String? type;
  String? contentType;
  String? url;

  factory DocumentFile.fromJson(Map<String, dynamic>? json) {
    return DocumentFile(
      id: json?['id'] == null ? null : json?['id'] as String,
      name: json?['name'] == null ? null : json?['name'] as String,
      type: json?['type'] == null ? null : json?['type'] as String,
      contentType: json?['contentType'] == null ? null : json?['contentType'] as String,
      url: json?['url'] == null ? null : json?['url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'contentType': contentType,
    'url': url,
  };
}