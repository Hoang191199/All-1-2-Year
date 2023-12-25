class  ConversationsFirebase{
  final String? avatar;
  final String? fullName;
  final String? username;
  final int? isDelete;
  final String? user_id;

  ConversationsFirebase({
    this.avatar, 
    this.fullName,
    this.username,
    this.isDelete,
    this.user_id
  });


  factory ConversationsFirebase.fromJson(Map<String, dynamic>? json) {
    return ConversationsFirebase(
      avatar: json?["avatar"] == null ? null : json?['avatar'] as String,
      fullName: json?["fullName"] == null ? null : json?['fullName'] as String,
      username: json?["username"] == null ? null : json?['username'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      isDelete: json?["isDelete"] == null ? null : json?['isDelete'] as int,
    );
  }

   Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "fullName": fullName,
    "username": username,
    "isDelete": isDelete,
    
  };
}