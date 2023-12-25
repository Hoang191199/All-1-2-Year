class BlogInfo {
  BlogInfo({
    required this.id,
    required this.name,
    required this.slug,
    this.thumbnailFileUrl
  });

  int id;
  String name;
  String slug;
  String? thumbnailFileUrl;

  factory BlogInfo.fromJson(Map<String, dynamic>? json) {
    return BlogInfo(
    id: json?['id'] as int,
    name: json?['name'] as String,
    slug: json?['slug'] as String,
    thumbnailFileUrl: json?['thumbnailFileUrl'] == null ? null : json?['thumbnailFileUrl'] as String
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnailFileUrl": thumbnailFileUrl
  };
}