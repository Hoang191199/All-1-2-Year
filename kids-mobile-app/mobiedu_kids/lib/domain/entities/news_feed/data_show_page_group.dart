import 'package:mobiedu_kids/domain/entities/news_feed/about_page.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/school_review.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';

class DataShowPageGroup {
  DataShowPageGroup({
    this.info_page,
    this.info_group,
    this.post,
    this.posts,
    this.pinned_post,
    this.school_review,
    this.about_page,
    this.members,
  });

  PageJoin? info_page;
  GroupJoin? info_group;
  List<PostNews>? post;
  List<PostNews>? posts;
  PostNews? pinned_post;
  List<SchoolReview>? school_review;
  AboutPage? about_page;
  List<User>? members;

  factory DataShowPageGroup.fromJson(Map<String, dynamic>? json) {
    return DataShowPageGroup(
      info_page: json?["info_page"] == null ? null : PageJoin.fromJson(json?["info_page"]),
      info_group: json?["info_group"] == null ? null : GroupJoin.fromJson(json?["info_group"]),
      post: json?["post"] == null ? [] : List<PostNews>.from(json?["post"].map((x) => PostNews.fromJson(x))),
      posts: json?["posts"] == null ? [] : List<PostNews>.from(json?["posts"].map((x) => PostNews.fromJson(x))),
      pinned_post: json?["pinned_post"] == null ? null : PostNews.fromJson(json?["pinned_post"]),
      school_review: json?["school_review"] == null ? [] : List<SchoolReview>.from(json?["school_review"].map((x) => SchoolReview.fromJson(x))),
      about_page: json?["about_page"] == null ? null : AboutPage.fromJson(json?["about_page"]),
      members: json?["members"] == null ? [] : List<User>.from(json?["members"].map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'info_page': info_page,
    'info_group': info_group,
    'post': post,
    'posts': posts,
    'pinned_post': pinned_post,
    'school_review': school_review,
    'about_page': about_page,
    'members': members,
  };
}