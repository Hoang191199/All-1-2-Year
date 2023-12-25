class MediaInfoDetails {
  MediaInfoDetails({this.id, this.name, this.slug});

  String? id;
  String? name;
  String? slug;

  factory MediaInfoDetails.fromJson(Map<String, dynamic>? json) {
    return MediaInfoDetails(
      id: json?["id"] == null ? null : json?['id'] as String,
      name: json?["name"] == null ? null : json?['name'] as String,
      slug: json?["slug"] == null ? null : json?['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
}
