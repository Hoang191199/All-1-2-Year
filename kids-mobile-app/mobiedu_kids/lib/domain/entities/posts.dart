import 'package:mobiedu_kids/domain/entities/post_details.dart';

class Posts {
  Posts({
    this.posts,
  });

  List<PostDetails>? posts;

  factory Posts.fromJson(Map<String, dynamic>? json) {
    return Posts(
      posts: json?["posts"] == null
          ? null
          : List<PostDetails>.from(
              json?["posts"].map((x) => PostDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'posts': posts,
      };
}
