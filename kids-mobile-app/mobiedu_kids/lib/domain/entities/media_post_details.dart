class MediaPostDetails {
  MediaPostDetails({
    this.id,
    this.post_date,
    this.post_title,
    this.post_name,
    this.post_views_count,
    this.thumbnail,
  });

  String? id;
  String? post_date;
  String? post_title;
  String? post_name;
  String? post_views_count;
  String? thumbnail;

  factory MediaPostDetails.fromJson(Map<String, dynamic>? json) {
    return MediaPostDetails(
      id: json?["id"] == null ? null : json?['id'] as String,
      post_date:
          json?["post_date"] == null ? null : json?['post_date'] as String,
      post_title:
          json?["post_title"] == null ? null : json?['post_title'] as String,
      post_name:
          json?["post_name"] == null ? null : json?['post_name'] as String,
      post_views_count: json?["post_views_count"] == null
          ? null
          : json?['post_views_count'] as String,
      thumbnail:
          json?["thumbnail"] == null ? null : json?['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_date": post_date,
        "post_title": post_title,
        "post_name": post_name,
        "post_views_count": post_views_count,
        "thumbnail": thumbnail
      };
}
