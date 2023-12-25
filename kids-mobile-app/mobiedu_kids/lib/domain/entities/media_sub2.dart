class MediaSub2<T> {
  MediaSub2({this.id, this.name, this.slug, this.sub2});

  String? id;
  String? name;
  String? slug;
  List<T>? sub2;

  factory MediaSub2.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MediaSub2(
      id: json?["id"] == null ? null : json?['id'] as String,
      name: json?["name"] == null ? null : json?['name'] as String,
      slug: json?["slug"] == null ? null : json?['slug'] as String,
      sub2: json?["sub2"] == null
          ? null
          : List<T>.from(json?["sub2"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "slug": slug, "sub2": sub2};
}
