import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';

class DataResponse {
  DataResponse({
    this.post,
  });

  PostNews? post;

  factory DataResponse.fromJson(Map<String, dynamic>? json) {
    return DataResponse(
      post: json?["post"] == null ? null : PostNews.fromJson(json?["post"]),
    );
  }

  Map<String, dynamic> toJson() => {
    'post': post,
  };
}