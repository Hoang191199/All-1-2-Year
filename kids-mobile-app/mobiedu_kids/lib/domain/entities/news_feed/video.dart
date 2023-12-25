class Video {
  Video({
    this.video_id,
    this.post_id,
    this.source,
    this.privacy,
  });

  String? video_id;
  String? post_id;
  String? source;
  String? privacy;

  factory Video.fromJson(Map<String, dynamic>? json) {
    return Video(
      video_id: json?["video_id"] == null ? null : json?['video_id'] as String,
      post_id: json?["post_id"] == null ? null : json?['post_id'] as String,
      source: json?["source"] == null ? null : json?['source'] as String,
      privacy: json?["privacy"] == null ? null : json?['privacy'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'video_id': video_id,
    'post_id': post_id,
    'source': source,
    'privacy': privacy,
  };
}