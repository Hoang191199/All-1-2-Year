class PostComment {
  PostComment({
    this.comment_id,
    this.node_id,
    this.node_type,
    this.user_id,
    this.user_type,
    this.text,
    this.image,
    this.time,
    this.likes,
    this.replies,
    this.user_name,
    this.user_fullname,
    this.user_picture,
    this.author_id,
    this.author_picture,
    this.author_name,
    this.edit_comment,
    this.delete_comment,
    this.i_like,
    this.comment_replies,
    this.level,
  });

  String? comment_id;
  String? node_id;
  String? node_type;
  String? user_id;
  String? user_type;
  String? text;
  String? image;
  String? time;
  String? likes;
  String? replies;
  String? user_name;
  String? user_fullname;
  String? user_picture;
  String? author_id;
  String? author_picture;
  String? author_name;
  bool? edit_comment;
  bool? delete_comment;
  bool? i_like;
  List<PostComment>? comment_replies;
  String? level;

  factory PostComment.fromJson(Map<String, dynamic>? json) {
    return PostComment(
      comment_id: json?["comment_id"] == null ? null : json?['comment_id'] as String,
      node_id: json?["node_id"] == null ? null : json?['node_id'] as String,
      node_type: json?["node_type"] == null ? null : json?['node_type'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type: json?["user_type"] == null ? null : json?['user_type'] as String,
      text: json?["text"] == null ? null : json?['text'] as String,
      image: json?["image"] == null ? null : json?['image'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as String,
      replies: json?["replies"] == null ? null : json?['replies'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      author_id: json?["author_id"] == null ? null : json?['author_id'] as String,
      author_picture: json?["author_picture"] == null ? null : json?['author_picture'] as String,
      author_name: json?["author_name"] == null ? null : json?['author_name'] as String,
      edit_comment: json?["edit_comment"] == null ? false : json?['edit_comment'] as bool,
      delete_comment: json?["delete_comment"] == null ? false : json?['delete_comment'] as bool,
      i_like: json?["i_like"] == null ? false : json?['i_like'] as bool,
      comment_replies: json?["comment_replies"] == null ? [] : List<PostComment>.from(json?["comment_replies"].map((x) => PostComment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'comment_id': comment_id,
    'node_id': node_id,
    'node_type': node_type,
    'user_id': user_id,
    'user_type': user_type,
    'text': text,
    'image': image,
    'time': time,
    'likes': likes,
    'replies': replies,
    'user_name': user_name,
    'user_fullname': user_fullname,
    'user_picture': user_picture,
    'author_id': author_id,
    'author_picture': author_picture,
    'author_name': author_name,
    'edit_comment': edit_comment,
    'delete_comment': delete_comment,
    'i_like': i_like,
  };
}