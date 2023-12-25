// import 'package:mobiedu_kids/domain/entities/firebase_messenger/conversations_firebase.dart';

class DataUserFireBase {
  final String? avatar;
  final String? fullName;
  final String? username;
  final int? isOnline;
  final String? user_id;
  final String? email;

  DataUserFireBase({
    this.avatar, 
    this.fullName,
    this.username,
    this.isOnline,
    this.user_id,
    this.email
  });


  factory DataUserFireBase.fromJson(Map<String, dynamic>? json) {
    return DataUserFireBase(
      avatar: json?["avatar"] == null ? null : json?['avatar'] as String,
      fullName: json?["fullName"] == null ? null : json?['fullName'] as String,
      username: json?["username"] == null ? null : json?['username'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      isOnline: json?["isOnline"] == null ? null : json?['isOnline'] as int,
    );
  }

   Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "fullName": fullName,
    "username": username,
    "isOnline": isOnline,
    'user_id': user_id,
    'email': email
  };
}