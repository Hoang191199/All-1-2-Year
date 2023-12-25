class JournalsInfo {
  JournalsInfo({
    this.caption,
    this.child_parent_id,
    this.child_journal_album_id,
    this.created_at,
    this.created_user_id,
    this.image_count,
    this.is_parent,
    this.thumbnail,
    this.updated_at,
  });

  String? caption;
  String? child_parent_id;
  String? child_journal_album_id;
  String? created_at;
  String? created_user_id;
  int? image_count;
  String? is_parent;
  String? thumbnail;
  String? updated_at;
  factory JournalsInfo.fromJson(Map<String, dynamic>? json) {
    return JournalsInfo(
      caption: json?["caption"] == null ? null : json?['caption'] as String,
      child_parent_id: json?["child_parent_id"] == null
          ? null
          : json?['child_parent_id'] as String,
      child_journal_album_id: json?["child_journal_album_id"] == null
          ? null
          : json?['child_journal_album_id'] as String,
      created_at:
          json?["created_at"] == null ? null : json?['created_at'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      image_count:
          json?["image_count"] == null ? null : json?['image_count'] as int,
      is_parent:
          json?["is_parent"] == null ? null : json?['is_parent'] as String,
      thumbnail:
          json?["thumbnail"] == null ? null : json?['thumbnail'] as String,
      updated_at:
          json?["updated_at"] == null ? null : json?['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "child_parent_id": child_parent_id,
        "child_journal_album_id": child_journal_album_id,
        "created_at": created_at,
        "created_user_id": created_user_id,
        "image_count": image_count,
        "is_parent": is_parent,
        "thumbnail": thumbnail,
        "updated_at": updated_at
      };
}
