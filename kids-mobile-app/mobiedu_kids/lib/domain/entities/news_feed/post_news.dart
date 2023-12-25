import 'package:mobiedu_kids/domain/entities/news_feed/album.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/photo_post.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/video.dart';

class PostNews {
  PostNews({
    this.post_id,
    this.user_id,
    this.user_type,
    this.group_id,
    this.post_type,
    this.time,
    this.privacy,
    this.text,
    this.likes,
    this.comments,
    this.shares,
    this.views_count,
    this.user_name,
    this.user_fullname,
    this.user_picture,
    this.user_cover,
    this.group_admin,
    this.group_name,
    this.group_title,
    this.group_picture,
    this.group_cover,
    this.author_id,
    this.post_author_picture,
    this.post_author_url,
    this.post_author_name,
    this.is_page_admin,
    this.is_group_admin,
    this.is_event_admin,
    this.pinned,
    this.allow_comment,
    this.manage_post,
    this.i_save,
    this.i_like,
    this.i_follow,
    this.photos_num,
    this.photos,
    this.og_image,
    this.post_comments,
    this.album,
    this.video,
    this.origin,
    this.page_id,
    this.page_admin,
    this.page_name,
    this.page_title,
    this.page_picture,
    this.page_cover,
  });

  String? post_id;
  String? user_id;
  String? user_type;
  String? group_id;
  String? post_type;
  String? time;
  String? privacy;
  String? text;
  String? likes;
  String? comments;
  String? shares;
  String? views_count;
  String? user_name;
  String? user_fullname;
  String? user_picture;
  String? user_cover;
  String? group_admin;
  String? group_name;
  String? group_title;
  String? group_picture;
  String? group_cover;
  String? author_id;
  String? post_author_picture;
  String? post_author_url;
  String? post_author_name;
  bool? is_page_admin;
  bool? is_group_admin;
  bool? is_event_admin;
  bool? pinned;
  bool? allow_comment;
  bool? manage_post;
  bool? i_save;
  bool? i_like;
  bool? i_follow;
  int? photos_num;
  List<PhotoPost>? photos;
  String? og_image;
  List<PostComment>? post_comments;
  Album? album;
  Video? video;
  PostNews? origin;
  String? page_id;
  String? page_admin;
  String? page_name;
  String? page_title;
  String? page_picture;
  String? page_cover;

  factory PostNews.fromJson(Map<String, dynamic>? json) {
    return PostNews(
      post_id: json?["post_id"] == null ? null : json?['post_id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type: json?["user_type"] == null ? null : json?['user_type'] as String,
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      post_type: json?["post_type"] == null ? null : json?['post_type'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      privacy: json?["privacy"] == null ? null : json?['privacy'] as String,
      text: json?["text"] == null ? null : json?['text'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as String,
      comments: json?["comments"] == null ? null : json?['comments'] as String,
      shares: json?["shares"] == null ? null : json?['shares'] as String,
      views_count: json?["views_count"] == null ? null : json?['views_count'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      user_cover: json?["user_cover"] == null ? null : json?['user_cover'] as String,
      group_admin: json?["group_admin"] == null ? null : json?['group_admin'] as String,
      group_name: json?["group_name"] == null ? null : json?['group_name'] as String,
      group_title: json?["group_title"] == null ? null : json?['group_title'] as String,
      group_picture: json?["group_picture"] == null ? null : json?['group_picture'] as String,
      group_cover: json?["group_cover"] == null ? null : json?['group_cover'] as String,
      author_id: json?["author_id"] == null ? null : json?['author_id'] as String,
      post_author_picture: json?["post_author_picture"] == null ? null : json?['post_author_picture'] as String,
      post_author_url: json?["post_author_url"] == null ? null : json?['post_author_url'] as String,
      post_author_name: json?["post_author_name"] == null ? null : json?['post_author_name'] as String,
      is_page_admin: json?["is_page_admin"] == null ? false : json?['is_page_admin'] as bool,
      is_group_admin: json?["is_group_admin"] == null ? false : json?['is_group_admin'] as bool,
      is_event_admin: json?["is_event_admin"] == null ? false : json?['is_event_admin'] as bool,
      pinned: json?["pinned"] == null ? false : json?['pinned'] as bool,
      allow_comment: json?["allow_comment"] == null ? false : json?['allow_comment'] as bool,
      manage_post: json?["manage_post"] == null ? false : json?['manage_post'] as bool,
      i_save: json?["i_save"] == null ? false : json?['i_save'] as bool,
      i_like: json?["i_like"] == null ? false : json?['i_like'] as bool,
      i_follow: json?["i_follow"] == null ? false : json?['i_follow'] as bool,
      photos_num: json?["photos_num"] == null ? null : json?['photos_num'] as int,
      photos: json?["photos"] == null ? [] : List<PhotoPost>.from(json?["photos"].map((x) => PhotoPost.fromJson(x))),
      og_image: json?["og_image"] == null ? null : json?['og_image'] as String,
      post_comments: json?["post_comments"] == null ? [] : List<PostComment>.from(json?["post_comments"].map((x) => PostComment.fromJson(x))),
      album: json?["album"] == null ? null : Album.fromJson(json?["album"]),
      video: json?["video"] == null ? null : Video.fromJson(json?["video"]),
      origin: json?["origin"] == null ? null : PostNews.fromJson(json?["origin"]),
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_admin: json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_name: json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title: json?["page_title"] == null ? null : json?['page_title'] as String,
      page_picture: json?["page_picture"] == null ? null : json?['page_picture'] as String,
      page_cover: json?["page_cover"] == null ? null : json?['page_cover'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'post_id': post_id,
    'user_id': user_id,
    'user_type': user_type,
    'group_id': group_id,
    'post_type': post_type,
    'time': time,
    'privacy': privacy,
    'text': text,
    'likes': likes,
    'comments': comments,
    'shares': shares,
    'views_count': views_count,
    'user_name': user_name,
    'user_fullname': user_fullname,
    'user_picture': user_picture,
    'user_cover': user_cover,
    'group_admin': group_admin,
    'group_name': group_name,
    'group_title': group_title,
    'group_picture': group_picture,
    'group_cover': group_cover,
    'author_id': author_id,
    'post_author_picture': post_author_picture,
    'post_author_url': post_author_url,
    'post_author_name': post_author_name,
    'is_page_admin': is_page_admin,
    'is_group_admin': is_group_admin,
    'is_event_admin': is_event_admin,
    'pinned': pinned,
    'allow_comment': allow_comment,
    'manage_post': manage_post,
    'i_save': i_save,
    'i_like': i_like,
    'i_follow': i_follow,
    'photos_num': photos_num,
    'photos': photos,
    'og_image': og_image,
    'post_comments': post_comments,
    'album': album,
    'video': video,
    'origin': origin,
    'page_id': page_id,
    'page_admin': page_admin,
    'page_name': page_name,
    'page_title': page_title,
    'page_picture': page_picture,
    'page_cover': page_cover,
  };
}