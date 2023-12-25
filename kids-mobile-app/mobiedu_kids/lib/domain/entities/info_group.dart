import 'package:mobiedu_kids/domain/entities/info_group_details.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';

class InfoGroup {
  InfoGroup({this.info_group, this.pinnedpost, this.posts});

  InfoGroupDetails? info_group;
  Object? pinnedpost;
  List<PostDetails>? posts;

  factory InfoGroup.fromJson(Map<String, dynamic>? json) {
    return InfoGroup(
      info_group: json?['info_group'] == null
          ? null
          : InfoGroupDetails.fromJson(json?['info_group']),
      pinnedpost: json?['info_group'] == null ? null : Object,
      posts: json?['posts'] == null
          ? null
          : List<PostDetails>.from(
              json?["posts"].map((x) => PostDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'info_group': info_group,
        'pinnedpost': pinnedpost,
        'posts': posts,
      };
}
