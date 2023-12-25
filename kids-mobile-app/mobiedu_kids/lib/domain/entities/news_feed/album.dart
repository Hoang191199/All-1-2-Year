import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';

class Album {
  Album({
    this.album_id,
    this.user_id,
    this.user_type,
    this.title,
    this.cover,
    this.photos_count,
    this.page_name,
    this.group_name,
    this.user_name,
    this.photos,
    this.in_group,
  });

  String? album_id;
  String? user_id;
  String? user_type;
  String? title;
  String? cover;
  int? photos_count;
  String? page_name;
  String? group_name;
  String? user_name;
  List<PhotoPost>? photos;
  String? in_group;

  factory Album.fromJson(Map<String, dynamic>? json) {
    return Album(
      album_id: json?["album_id"] == null ? null : json?['album_id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type: json?["user_type"] == null ? null : json?['user_type'] as String,
      title: json?["title"] == null ? null : json?['title'] as String,
      cover: json?["cover"] == null ? null : json?['cover'] as String,
      photos_count: json?["photos_count"] == null ? null : json?['photos_count'] as int,
      page_name: json?["page_name"] == null ? null : json?['page_name'] as String,
      group_name: json?["group_name"] == null ? null : json?['group_name'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      photos: json?["photos"] == null ? [] : List<PhotoPost>.from(json?["photos"].map((x) => PhotoPost.fromJson(x))),
      in_group: json?["in_group"] == null ? null : json?['in_group'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'album_id': album_id,
    'user_id': user_id,
    'user_type': user_type,
    'title': title,
    'cover': cover,
    'photos_count': photos_count,
    'page_name': page_name,
    'group_name': group_name,
    'user_name': user_name,
    'photos': photos,
    'in_group': in_group,
  };
}