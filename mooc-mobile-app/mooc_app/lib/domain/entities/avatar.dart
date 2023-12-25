class Avatar {
  Avatar({
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

  factory Avatar.fromJson(Map<String, dynamic>? json) {
    return Avatar(
      id: json?['id'] == null ? null : json?['id'] as String,
      url: json?['url'] == null ? null : json?['url'] as String,
      contentType: json?['contentType'] == null ? null : json?['contentType'] as String,
      name: json?['name'] == null ? null : json?['name'] as String,
      type: json?['type'] == null ? null : json?['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'contentType': contentType,
    'name': name,
    'type': type,
  };
}