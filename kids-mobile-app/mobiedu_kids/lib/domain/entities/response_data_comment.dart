import 'package:mobiedu_kids/domain/entities/post_comments.dart';

class ResponseDataComment<T> {
  ResponseDataComment({
    this.message,
    this.code,
    this.comment,
    // this.error,
    this.data,
  });

  String? message;
  int? code;
  List<PostComments>? comment;
  // bool? error;
  T? data;

  factory ResponseDataComment.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ResponseDataComment<T>(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      comment: json?['comment'] == null
          ? null
          : List<PostComments>.from(
              json?["comment"].map((x) => PostComments.fromJson(x))),
      // error: json?['error'] == null ? false : json?['error'] as bool,
      data: json?['data'] == null ? null : create(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'comment': comment,
        // 'error': error,
        'data': data,
      };
}
