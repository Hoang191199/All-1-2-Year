import 'package:mobiedu_kids/domain/entities/post_details.dart';

class Post {
  Post({
    this.post,
  });

  PostDetails? post;

  factory Post.fromJson(Map<String, dynamic>? json) {
    return Post(
      post: json?["post"] == null ? null : PostDetails.fromJson(json?['post']),
    );
  }

  Map<String, dynamic> toJson() => {
        'post': post,
      };
}
