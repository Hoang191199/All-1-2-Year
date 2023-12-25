import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';

class DataHomePage {
  DataHomePage({
    this.profile,
    this.posts,
    this.friends,
  });

  User? profile;
  List<PostNews>? posts;
  List<User>? friends;

  factory DataHomePage.fromJson(Map<String, dynamic>? json) {
    return DataHomePage(
      profile: json?["profile"] == null ? null : User.fromJson(json?["profile"]),
      posts: json?["posts"] == null ? [] : List<PostNews>.from(json?["posts"].map((x) => PostNews.fromJson(x))),
      friends: json?["friends"] == null ? [] : List<User>.from(json?["friends"].map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'profile': profile,
    'posts': posts,
    'friends': friends,
  };
}