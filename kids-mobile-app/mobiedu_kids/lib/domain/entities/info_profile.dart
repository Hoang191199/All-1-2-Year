import 'package:mobiedu_kids/domain/entities/info_profile_details.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';

class InfoProfile {
  InfoProfile({this.profile, this.posts});

  InfoProfileDetails? profile;
  List<PostNews>? posts;

  factory InfoProfile.fromJson(Map<String, dynamic>? json) {
    return InfoProfile(
      profile: json?['profile'] == null
          ? null
          : InfoProfileDetails.fromJson(json?['profile']),
      posts: json?['posts'] == null
          ? null
          : List<PostNews>.from(
              json?["posts"].map((x) => PostNews.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'profile': profile,
        'posts': posts,
      };
}
