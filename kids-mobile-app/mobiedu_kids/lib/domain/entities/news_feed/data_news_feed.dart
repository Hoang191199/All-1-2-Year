import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';

class DataNewsFeed {
  DataNewsFeed({
    this.allow_user_post_on_wall,
    this.newsfeed_enabled,
    this.posts,
  });

  bool? allow_user_post_on_wall;
  bool? newsfeed_enabled;
  List<PostNews>? posts;

  factory DataNewsFeed.fromJson(Map<String, dynamic>? json) {
    return DataNewsFeed(
      allow_user_post_on_wall: json?["allow_user_post_on_wall"] == null ? false : json?['allow_user_post_on_wall'] as bool,
      newsfeed_enabled: json?["newsfeed_enabled"] == null ? false : json?['newsfeed_enabled'] as bool,
      posts: json?["posts"] == [] ? [] : List<PostNews>.from(json?["posts"].map((x) => PostNews.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'allow_user_post_on_wall': allow_user_post_on_wall,
    'newsfeed_enabled': newsfeed_enabled,
    'posts': posts,
  };
}