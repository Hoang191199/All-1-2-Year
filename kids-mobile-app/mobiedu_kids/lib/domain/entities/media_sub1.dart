class MediaSub1<T> {
  MediaSub1({this.id, this.name, this.slug, this.sub1});

  String? id;
  String? name;
  String? slug;
  List<T>? sub1;

  factory MediaSub1.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MediaSub1(
      id: json?["id"] == null ? null : json?['id'] as String,
      name: json?["name"] == null ? null : json?['name'] as String,
      slug: json?["slug"] == null ? null : json?['slug'] as String,
      sub1: json?["sub1"] == null
          ? null
          : List<T>.from(json?["sub1"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "slug": slug, "sub1": sub1};
}
