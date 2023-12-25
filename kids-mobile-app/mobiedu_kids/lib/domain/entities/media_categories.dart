class MediaCategories<T> {
  MediaCategories({
    this.categories,
  });

  T? categories;

  factory MediaCategories.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MediaCategories<T>(
      categories:
          json?["categories"] == null ? null : create(json?['categories']),
    );
  }

  Map<String, dynamic> toJson() => {
        'categories': categories,
      };
}
