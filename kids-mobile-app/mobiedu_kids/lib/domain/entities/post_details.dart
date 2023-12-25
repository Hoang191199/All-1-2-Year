import 'package:mobiedu_kids/domain/entities/photos_info.dart';
import 'package:mobiedu_kids/domain/entities/post_comments.dart';

class PostDetails {
  PostDetails(
      {this.post_id,
      this.user_id,
      this.user_type,
      this.in_group,
      this.group_id,
      this.in_wall,
      this.wall_id,
      this.post_type,
      this.origin_id,
      this.time,
      this.location,
      this.privacy,
      this.text,
      this.likes,
      this.comments,
      this.shares,
      this.school_id,
      this.views_count,
      this.in_event,
      this.event_id,
      this.feeling_action,
      this.feeling_value,
      this.boosted,
      this.boosted_by,
      this.user_name,
      this.user_fullname,
      this.user_firstname,
      this.user_lastname,
      this.user_gender,
      this.user_picture,
      this.user_cover,
      this.user_picture_id,
      this.user_cover_id,
      this.user_verified,
      this.user_pinned_post,
      this.page_id,
      this.page_admin,
      this.page_category,
      this.page_name,
      this.page_title,
      this.page_description,
      this.page_picture,
      this.page_picture_id,
      this.page_cover,
      this.page_cover_id,
      this.page_album_pictures,
      this.page_album_covers,
      this.page_album_timeline,
      this.page_pinned_post,
      this.page_verified,
      this.page_likes,
      this.views_in_thirty_days,
      this.city_id,
      this.telephone,
      this.website,
      this.email,
      this.address,
      this.page_date,
      this.page_boosted,
      this.page_boosted_by,
      this.page_company,
      this.page_phone,
      this.page_website,
      this.page_location,
      this.page_action_text,
      this.page_action_color,
      this.page_action_url,
      this.page_social_facebook,
      this.page_social_twitter,
      this.page_social_google,
      this.page_social_youtube,
      this.page_social_instagram,
      this.page_social_linkedin,
      this.page_social_vkontakte,
      this.group_privacy,
      this.group_category,
      this.group_admin,
      this.group_name,
      this.group_title,
      this.group_picture,
      this.group_picture_id,
      this.group_cover,
      this.group_cover_id,
      this.group_album_pictures,
      this.group_album_covers,
      this.group_album_timeline,
      this.group_pinned_post,
      this.group_description,
      this.group_members,
      this.class_level_id,
      this.camera_url,
      this.group_date,
      this.status,
      this.school_allow_comment,
      this.class_allow_comment,
      this.author_id,
      this.is_page_admin,
      this.is_group_admin,
      this.is_event_admin,
      this.post_author_picture,
      this.post_author_url,
      this.post_author_name,
      this.post_author_verified,
      this.post_comments,
      this.pinned,
      this.allow_comment,
      this.manage_post,
      this.i_save,
      this.i_like,
      this.text_plain,
      this.og_title,
      this.og_description,
      this.photos_num,
      this.photos,
      this.og_image,
      this.i_follow});

  String? post_id;
  String? user_id;
  String? user_type;
  String? in_group;
  String? group_id;
  String? in_wall;
  String? wall_id;
  String? post_type;
  String? origin_id;
  String? time;
  String? location;
  String? privacy;
  String? text;
  String? likes;
  String? comments;
  String? shares;
  String? school_id;
  String? views_count;
  String? in_event;
  String? event_id;
  String? feeling_action;
  String? feeling_value;
  String? boosted;
  String? boosted_by;
  String? user_name;
  String? user_fullname;
  String? user_firstname;
  String? user_lastname;
  String? user_gender;
  String? user_picture;
  String? user_cover;
  String? user_picture_id;
  String? user_cover_id;
  String? user_verified;
  String? user_pinned_post;
  String? page_id;
  String? page_admin;
  String? page_category;
  String? page_name;
  String? page_title;
  String? page_description;
  String? page_picture;
  String? page_picture_id;
  String? page_cover;
  String? page_cover_id;
  String? page_album_pictures;
  String? page_album_covers;
  String? page_album_timeline;
  String? page_pinned_post;
  String? page_verified;
  String? page_likes;
  String? views_in_thirty_days;
  String? city_id;
  String? telephone;
  String? website;
  String? email;
  String? address;
  String? page_date;
  String? page_boosted;
  String? page_boosted_by;
  String? page_company;
  String? page_phone;
  String? page_website;
  String? page_location;
  String? page_action_text;
  String? page_action_color;
  String? page_action_url;
  String? page_social_facebook;
  String? page_social_twitter;
  String? page_social_google;
  String? page_social_youtube;
  String? page_social_instagram;
  String? page_social_linkedin;
  String? page_social_vkontakte;
  String? group_privacy;
  String? group_category;
  String? group_admin;
  String? group_name;
  String? group_title;
  String? group_picture;
  String? group_picture_id;
  String? group_cover;
  String? group_cover_id;
  String? group_album_pictures;
  String? group_album_covers;
  String? group_album_timeline;
  String? group_pinned_post;
  String? group_description;
  String? group_members;
  String? class_level_id;
  String? camera_url;
  String? group_date;
  String? status;
  String? school_allow_comment;
  String? class_allow_comment;
  String? author_id;
  bool? is_page_admin;
  bool? is_group_admin;
  bool? is_event_admin;
  String? post_author_picture;
  String? post_author_url;
  String? post_author_name;
  String? post_author_verified;
  List<PostComments>? post_comments;
  bool? pinned;
  bool? allow_comment;
  bool? manage_post;
  bool? i_save;
  bool? i_like;
  String? text_plain;
  String? og_title;
  String? og_description;
  int? photos_num;
  List<PhotosInfo>? photos;
  String? og_image;
  bool? i_follow;

  factory PostDetails.fromJson(Map<String, dynamic>? json) {
    return PostDetails(
      post_id: json?["post_id"] == null ? null : json?['post_id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type:
          json?["user_type"] == null ? null : json?['user_type'] as String,
      in_group: json?["in_group"] == null ? null : json?['in_group'] as String,
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      in_wall: json?["in_wall"] == null ? null : json?['in_wall'] as String,
      wall_id: json?["wall_id"] == null ? null : json?['wall_id'] as String,
      post_type:
          json?["post_type"] == null ? null : json?['post_type'] as String,
      origin_id:
          json?["origin_id"] == null ? null : json?['origin_id'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      location: json?["location"] == null ? null : json?['location'] as String,
      privacy: json?["privacy"] == null ? null : json?['privacy'] as String,
      text: json?["text"] == null ? null : json?['text'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as String,
      comments: json?["comments"] == null ? null : json?['comments'] as String,
      shares: json?["shares"] == null ? null : json?['shares'] as String,
      school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
      views_count:
          json?["views_count"] == null ? null : json?['views_count'] as String,
      in_event: json?["in_event"] == null ? null : json?['in_event'] as String,
      event_id: json?["event_id"] == null ? null : json?['event_id'] as String,
      feeling_action: json?["feeling_action"] == null
          ? null
          : json?['feeling_action'] as String,
      feeling_value: json?["feeling_value"] == null
          ? null
          : json?['feeling_value'] as String,
      boosted: json?["boosted"] == null ? null : json?['boosted'] as String,
      boosted_by:
          json?["boosted_by"] == null ? null : json?['boosted_by'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null
          ? null
          : json?['user_fullname'] as String,
      user_firstname: json?["user_firstname"] == null
          ? null
          : json?['user_firstname'] as String,
      user_lastname: json?["user_lastname"] == null
          ? null
          : json?['user_lastname'] as String,
      user_gender:
          json?["user_gender"] == null ? null : json?['user_gender'] as String,
      user_picture: json?["user_picture"] == null
          ? null
          : json?['user_picture'] as String,
      user_cover:
          json?["user_cover"] == null ? null : json?['user_cover'] as String,
      user_picture_id: json?["user_picture_id"] == null
          ? null
          : json?['user_picture_id'] as String,
      user_cover_id: json?["user_cover_id"] == null
          ? null
          : json?['user_cover_id'] as String,
      user_verified: json?["user_verified"] == null
          ? null
          : json?['user_verified'] as String,
      user_pinned_post: json?["user_pinned_post"] == null
          ? null
          : json?['user_pinned_post'] as String,
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_admin:
          json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_category: json?["page_category"] == null
          ? null
          : json?['page_category'] as String,
      page_name:
          json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title:
          json?["page_title"] == null ? null : json?['page_title'] as String,
      page_description: json?["page_description"] == null
          ? null
          : json?['page_description'] as String,
      page_picture: json?["page_picture"] == null
          ? null
          : json?['page_picture'] as String,
      page_picture_id: json?["page_picture_id"] == null
          ? null
          : json?['page_picture_id'] as String,
      page_cover:
          json?["page_cover"] == null ? null : json?['page_cover'] as String,
      page_cover_id: json?["page_cover_id"] == null
          ? null
          : json?['page_cover_id'] as String,
      page_album_pictures: json?["page_album_pictures"] == null
          ? null
          : json?['page_album_pictures'] as String,
      page_album_covers: json?["page_album_covers"] == null
          ? null
          : json?['page_album_covers'] as String,
      page_album_timeline: json?["page_album_timeline"] == null
          ? null
          : json?['page_album_timeline'] as String,
      page_pinned_post: json?["page_pinned_post"] == null
          ? null
          : json?['page_pinned_post'] as String,
      page_verified: json?["page_verified"] == null
          ? null
          : json?['page_verified'] as String,
      page_likes:
          json?["page_likes"] == null ? null : json?['page_likes'] as String,
      views_in_thirty_days: json?["views_in_thirty_days"] == null
          ? null
          : json?['views_in_thirty_days'] as String,
      city_id: json?["city_id"] == null ? null : json?['city_id'] as String,
      telephone:
          json?["telephone"] == null ? null : json?['telephone'] as String,
      website: json?["website"] == null ? null : json?['website'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      page_date:
          json?["page_date"] == null ? null : json?['page_date'] as String,
      page_boosted: json?["page_boosted"] == null
          ? null
          : json?['page_boosted'] as String,
      page_boosted_by: json?["page_boosted_by"] == null
          ? null
          : json?['page_boosted_by'] as String,
      page_company: json?["page_company"] == null
          ? null
          : json?['page_company'] as String,
      page_phone:
          json?["page_phone"] == null ? null : json?['page_phone'] as String,
      page_website: json?["page_website"] == null
          ? null
          : json?['page_website'] as String,
      page_location: json?["page_location"] == null
          ? null
          : json?['page_location'] as String,
      page_action_text: json?["page_action_text"] == null
          ? null
          : json?['page_action_text'] as String,
      page_action_color: json?["page_action_color"] == null
          ? null
          : json?['page_action_color'] as String,
      page_action_url: json?["page_action_url"] == null
          ? null
          : json?['page_action_url'] as String,
      page_social_facebook: json?["page_social_facebook"] == null
          ? null
          : json?['page_social_facebook'] as String,
      page_social_twitter: json?["page_social_twitter"] == null
          ? null
          : json?['page_social_twitter'] as String,
      page_social_google: json?["page_social_google"] == null
          ? null
          : json?['page_social_google'] as String,
      page_social_youtube: json?["page_social_youtube"] == null
          ? null
          : json?['page_social_youtube'] as String,
      page_social_instagram: json?["page_social_instagram"] == null
          ? null
          : json?['page_social_instagram'] as String,
      page_social_linkedin: json?["page_social_linkedin"] == null
          ? null
          : json?['page_social_linkedin'] as String,
      page_social_vkontakte: json?["page_social_vkontakte"] == null
          ? null
          : json?['page_social_vkontakte'] as String,
      group_privacy: json?["group_privacy"] == null
          ? null
          : json?['group_privacy'] as String,
      group_category: json?["group_category"] == null
          ? null
          : json?['group_category'] as String,
      group_admin:
          json?["group_admin"] == null ? null : json?['group_admin'] as String,
      group_name:
          json?["group_name"] == null ? null : json?['group_name'] as String,
      group_title:
          json?["group_title"] == null ? null : json?['group_title'] as String,
      group_picture: json?["group_picture"] == null
          ? null
          : json?['group_picture'] as String,
      group_picture_id: json?["group_picture_id"] == null
          ? null
          : json?['group_picture_id'] as String,
      group_cover:
          json?["group_cover"] == null ? null : json?['group_cover'] as String,
      group_cover_id: json?["group_cover_id"] == null
          ? null
          : json?['group_cover_id'] as String,
      group_album_pictures: json?["group_album_pictures"] == null
          ? null
          : json?['group_album_pictures'] as String,
      group_album_covers: json?["group_album_covers"] == null
          ? null
          : json?['group_album_covers'] as String,
      group_album_timeline: json?["group_album_timeline"] == null
          ? null
          : json?['group_album_timeline'] as String,
      group_pinned_post: json?["group_pinned_post"] == null
          ? null
          : json?['group_pinned_post'] as String,
      group_description: json?["group_description"] == null
          ? null
          : json?['group_description'] as String,
      group_members: json?["group_members"] == null
          ? null
          : json?['group_members'] as String,
      class_level_id: json?["class_level_id"] == null
          ? null
          : json?['class_level_id'] as String,
      camera_url:
          json?["camera_url"] == null ? null : json?['camera_url'] as String,
      group_date:
          json?["group_date"] == null ? null : json?['group_date'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      school_allow_comment: json?["school_allow_comment"] == null
          ? null
          : json?['school_allow_comment'] as String,
      class_allow_comment: json?["class_allow_comment"] == null
          ? null
          : json?['class_allow_comment'] as String,
      author_id:
          json?["author_id"] == null ? null : json?['author_id'] as String,
      is_page_admin: json?["is_page_admin"] == null
          ? null
          : json?['is_page_admin'] as bool,
      is_group_admin: json?["is_group_admin"] == null
          ? null
          : json?['is_group_admin'] as bool,
      is_event_admin: json?["is_event_admin"] == null
          ? null
          : json?['is_event_admin'] as bool,
      post_author_picture: json?["post_author_picture"] == null
          ? null
          : json?['post_author_picture'] as String,
      post_author_url: json?["post_author_url"] == null
          ? null
          : json?['post_author_url'] as String,
      post_author_name: json?["post_author_name"] == null
          ? null
          : json?['post_author_name'] as String,
      post_author_verified: json?["post_author_verified"] == null
          ? null
          : json?['post_author_verified'] as String,
      post_comments: json?["post_comments"] == null
          ? null
          : List<PostComments>.from(
              json?["post_comments"].map((x) => PostComments.fromJson(x))),
      pinned: json?["pinned"] == null ? null : json?['pinned'] as bool,
      allow_comment: json?["allow_comment"] == null
          ? null
          : json?['allow_comment'] as bool,
      manage_post:
          json?["manage_post"] == null ? null : json?['manage_post'] as bool,
      i_save: json?["i_save"] == null ? null : json?['i_save'] as bool,
      i_like: json?["i_like"] == null ? null : json?['i_like'] as bool,
      text_plain:
          json?["text_plain"] == null ? null : json?['text_plain'] as String,
      og_title: json?["og_title"] == null ? null : json?['og_title'] as String,
      og_description: json?["og_description"] == null
          ? null
          : json?['og_description'] as String,
      photos_num:
          json?["photos_num"] == null ? null : json?['photos_num'] as int,
      photos: json?["photos"] == null
          ? null
          : List<PhotosInfo>.from(
              json?["photos"].map((x) => PhotosInfo.fromJson(x))),
      og_image: json?["og_image"] == null ? null : json?['og_image'] as String,
      i_follow: json?["i_follow"] == null ? null : json?['i_follow'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "post_id": post_id,
        "user_id": user_id,
        "user_type": user_type,
        "in_group": in_group,
        "group_id": group_id,
        "in_wall": in_wall,
        "wall_id": group_id,
        "post_type": post_type,
        "origin_id": origin_id,
        "time": time,
        "location": location,
        "privacy": privacy,
        "text": text,
        "likes": likes,
        "comments": comments,
        "shares": shares,
        "school_id": school_id,
        "views_count": views_count,
        "in_event": in_event,
        "event_id": event_id,
        "feeling_action": feeling_action,
        "feeling_value": feeling_value,
        "boosted": "boosted",
        "boosted_by": boosted_by,
        "user_name": user_name,
        "user_fullname": user_fullname,
        "user_firstname": user_firstname,
        "user_lastname": user_lastname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "user_cover": user_cover,
        "user_picture_id": user_picture_id,
        "user_cover_id": user_cover_id,
        "user_verified": user_verified,
        "user_pinned_post": user_pinned_post,
        "page_id": page_id,
        "page_admin": page_admin,
        "page_category": page_category,
        "page_name": page_name,
        "page_title": page_title,
        "page_description": page_description,
        "page_picture": page_picture,
        "page_picture_id": page_picture_id,
        "page_cover": page_cover,
        "page_cover_id": page_cover_id,
        "page_album_pictures": page_album_pictures,
        "page_album_covers": page_album_covers,
        "page_album_timeline": page_album_timeline,
        "page_pinned_post": page_pinned_post,
        "page_verified": page_verified,
        "page_likes": page_likes,
        "views_in_thirty_days": views_in_thirty_days,
        "city_id": city_id,
        "telephone": telephone,
        "website": website,
        "email": email,
        "address": address,
        "page_date": page_date,
        "page_boosted": page_boosted,
        "page_boosted_by": page_boosted_by,
        "page_company": page_company,
        "page_phone": page_phone,
        "page_website": page_website,
        "page_location": page_location,
        "page_action_text": page_action_text,
        "page_action_color": page_action_color,
        "page_action_url": page_action_url,
        "page_social_facebook": page_social_facebook,
        "page_social_twitter": page_social_twitter,
        "page_social_google": page_social_google,
        "page_social_youtube": page_social_youtube,
        "page_social_instagram": page_social_instagram,
        "page_social_linkedin": page_social_linkedin,
        "page_social_vkontakte": page_social_vkontakte,
        "group_privacy": group_privacy,
        "group_category": group_category,
        "group_admin": group_admin,
        "group_name": group_name,
        "group_title": group_title,
        "group_picture": group_picture,
        "group_picture_id": group_picture_id,
        "group_cover": group_cover,
        "group_cover_id": group_cover_id,
        "group_album_pictures": group_album_pictures,
        "group_album_covers": group_album_covers,
        "group_album_timeline": group_album_timeline,
        "group_pinned_post": group_pinned_post,
        "group_description": group_description,
        "group_members": group_members,
        "class_level_id": class_level_id,
        "camera_url": camera_url,
        "group_date": group_date,
        "status": status,
        "school_allow_comment": school_allow_comment,
        "class_allow_comment": class_allow_comment,
        "author_id": author_id,
        "is_page_admin": is_page_admin,
        "is_group_admin": is_group_admin,
        "is_event_admin": is_event_admin,
        "post_author_picture": post_author_picture,
        "post_author_url": post_author_url,
        "post_author_name": post_author_name,
        "post_author_verified": post_author_verified,
        "post_comments": post_comments,
        "pinned": pinned,
        "allow_comment": allow_comment,
        "manage_post": manage_post,
        "i_save": i_save,
        "i_like": i_like,
        "text_plain": text_plain,
        "og_title": og_title,
        "og_description": og_description,
        "photos_num": photos_num,
        "photos": photos,
        "og_image": og_image,
        "i_follow": i_follow,
      };
}
