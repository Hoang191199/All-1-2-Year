import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';

class ResponsePost {
  ResponsePost({
    this.message,
    this.code,
    this.comment,
    this.data,
  });

  String? message;
  int? code;
  List<PostComment>? comment;
  PostNews? data;

  factory ResponsePost.fromJson(Map<String, dynamic>? json) {
    return ResponsePost(
      message: json?["message"] == null ? null : json?['message'] as String,
      code: json?["code"] == null ? null : json?['code'] as int,
      comment: json?["comment"] == null ? [] : List<PostComment>.from(json?["comment"].map((x) => PostComment.fromJson(x))),
      data: json?["data"] == null ? null : PostNews.fromJson(json?["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'comment': comment,
    'data': data,
  };
}