import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';

class DataPost{
  DataPost({
    this.posts
  });
  List<PostNews>? posts;

factory DataPost.fromJson(Map<String, dynamic>? json) {
    return DataPost(
      posts:json?['posts'] == null ? null : List<PostNews>.from(json?["posts"].map((x) => PostNews.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'posts': posts,
  };

}