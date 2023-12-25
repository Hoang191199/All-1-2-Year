class FriendRequest {
  FriendRequest({
    this.id,
    this.user_id,
    this.user_fullname,
    this.user_picture,
  });

  String? id;
  String? user_id;
  String? user_fullname;
  String? user_picture;

  factory FriendRequest.fromJson(Map<String, dynamic>? json) {
    return FriendRequest(
      id: json?["id"] == null ? null : json?['id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': user_id,
    'user_fullname': user_fullname,
    'user_picture': user_picture,
  };
}