import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';

class DataSearchNewsFeed {
  DataSearchNewsFeed({
    this.posts,
    this.users,
    this.pages,
    this.groups,
  });

  List<PostNews>? posts;
  List<User>? users;
  List<PageJoin>? pages;
  List<GroupJoin>? groups;

  factory DataSearchNewsFeed.fromJson(Map<String, dynamic>? json) {
    return DataSearchNewsFeed(
      posts: json?["posts"] == null ? [] : List<PostNews>.from(json?["posts"].map((x) => PostNews.fromJson(x))),
      users: json?["users"] == null ? [] : List<User>.from(json?["users"].map((x) => User.fromJson(x))),
      pages: json?["pages"] == null ? [] : List<PageJoin>.from(json?["pages"].map((x) => PageJoin.fromJson(x))),
      groups: json?["groups"] == null ? [] : List<GroupJoin>.from(json?["groups"].map((x) => GroupJoin.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'posts': posts,
    'users': users,
    'pages': pages,
    'groups': groups,
  };
}