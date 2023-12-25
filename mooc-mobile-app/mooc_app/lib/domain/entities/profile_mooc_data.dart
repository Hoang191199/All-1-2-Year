import 'package:mooc_app/domain/entities/profile_mooc.dart';

class ProfileMoocData {
  ProfileMoocData({
    this.message,
    this.code,
    this.error,
    this.data
  });
  String? message;
  int? code;
  bool? error;
  ProfileMooc? data;
  factory ProfileMoocData.fromJson(Map<String, dynamic>? json) {
    return ProfileMoocData(
      message: json?["message"] == null ? null : json?['message'] as String,
      code: json?["code"] == null ? null : json?['code'] as int,
      error: json?["error"] == null ? true : json?['error'] as bool,
      data: json?['data'] == null ? null : ProfileMooc.fromJson(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'error': error,
    'data': data,
  };
}