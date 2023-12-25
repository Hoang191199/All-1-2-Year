import 'package:mooc_app/domain/entities/blog_details_info.dart';

class BlogDetails {
  BlogDetails({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  String? message;
  int? code;
  bool? error;
  BlogDetailInfo? data;

  factory BlogDetails.fromJson(Map<String, dynamic>? json) {
    return BlogDetails(
      message: json?["message"] == null ? null : json?['message'] as String,
      code: json?["code"] == null ? null : json?['code'] as int,
      error: json?["error"] == null ? true : json?['error'] as bool,
      data:  json?["data"] == null ? null : json?['data'] as BlogDetailInfo,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'error': error,
    'data': data,
  };
}