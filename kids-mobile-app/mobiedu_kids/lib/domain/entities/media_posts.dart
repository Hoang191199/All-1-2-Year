import 'package:mobiedu_kids/domain/entities/media_post_details.dart';

class MediaPosts {
  MediaPosts({
    this.posts,
  });

  List<MediaPostDetails>? posts;

  factory MediaPosts.fromJson(Map<String, dynamic>? json) {
    return MediaPosts(
      posts: json?["posts"] == null
          ? null
          : List<MediaPostDetails>.from(
              json?["posts"].map((x) => MediaPostDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'posts': posts,
      };
}
