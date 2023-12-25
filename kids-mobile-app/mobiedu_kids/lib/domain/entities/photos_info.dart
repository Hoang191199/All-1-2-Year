class PhotosInfo {
  PhotosInfo({
    this.photo_id,
    this.post_id,
    this.album_id,
    this.source,
    this.likes,
    this.comments,
  });

  String? photo_id;
  String? post_id;
  String? album_id;
  String? source;
  String? likes;
  String? comments;

  factory PhotosInfo.fromJson(Map<String, dynamic>? json) {
    return PhotosInfo(
      photo_id: json?["photo_id"] == null ? null : json?['photo_id'] as String,
      post_id: json?["post_id"] == null ? null : json?['post_id'] as String,
      album_id: json?["album_id"] == null ? null : json?['album_id'] as String,
      source: json?["source"] == null ? null : json?['source'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as String,
      comments: json?["comments"] == null ? null : json?['comments'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "photo_id": photo_id,
        "post_id": post_id,
        "album_id": album_id,
        "source": source,
        "likes": likes,
        "comments": comments
      };
}
