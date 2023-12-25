class CommentInfo {
  CommentInfo(
      {this.node_id,
      this.node_type,
      this.text,
      this.image,
      this.time,
      this.likes,
      this.replies,
      this.user_id,
      this.user_type,
      this.author_picture,
      this.author_url,
      this.author_name,
      this.author_verified,
      this.author_user_name,
      this.comment_id,
      this.text_plain,
      this.edit_comment,
      this.delete_comment});
  String? node_id;
  String? node_type;
  String? text;
  String? image;
  String? time;
  int? likes;
  int? replies;
  String? user_id;
  String? user_type;
  String? author_picture;
  String? author_url;
  String? author_name;
  String? author_verified;
  String? author_user_name;
  int? comment_id;
  String? text_plain;
  bool? edit_comment;
  bool? delete_comment;
  factory CommentInfo.fromJson(Map<String, dynamic>? json) {
    return CommentInfo(
      node_id: json?["node_id"] == null ? null : json?['node_id'] as String,
      node_type:
          json?["node_type"] == null ? null : json?['node_type'] as String,
      text: json?["text"] == null ? null : json?['text'] as String,
      image: json?["image"] == null ? null : json?['image'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as int,
      replies: json?["replies"] == null ? null : json?['replies'] as int,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type:
          json?["user_type"] == null ? null : json?['user_type'] as String,
      author_picture: json?["author_picture"] == null
          ? null
          : json?['author_picture'] as String,
      author_url:
          json?["author_url"] == null ? null : json?['author_url'] as String,
      author_name:
          json?["author_name"] == null ? null : json?['author_name'] as String,
      author_verified: json?["author_verified"] == null
          ? null
          : json?['author_verified'] as String,
      author_user_name: json?["author_user_name"] == null
          ? null
          : json?['author_user_name'] as String,
      comment_id:
          json?["comment_id"] == null ? null : json?['comment_id'] as int,
      text_plain:
          json?["text_plain"] == null ? null : json?['text_plain'] as String,
      edit_comment:
          json?["edit_comment"] == null ? null : json?['edit_comment'] as bool,
      delete_comment: json?["delete_comment"] == null
          ? null
          : json?['delete_comment'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "node_id": node_id,
        "node_type": node_type,
        "text": text,
        "image": image,
        "time": time,
        "likes": likes,
        "replies": replies,
        "user_id": user_id,
        "user_type": user_type,
        "author_picture": author_picture,
        "author_url": author_url,
        "author_name": author_name,
        "author_verified": author_verified,
        "author_user_name": author_user_name,
        "comment_id": comment_id,
        "text_plain": text_plain,
        "edit_comment": edit_comment,
        "delete_comment": delete_comment
      };
}
