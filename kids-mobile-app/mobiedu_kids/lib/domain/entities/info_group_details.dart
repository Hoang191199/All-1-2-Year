class InfoGroupDetails {
  InfoGroupDetails({
    this.group_id,
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
    this.telephone,
    this.email,
    this.camera_url,
    this.group_date,
    this.status,
    this.school_id,
    this.category_name,
    this.group_picture_default,
    this.i_joined,
    this.i_admin,
    this.total_requests,
    this.class_allow_post,
    this.class_change_cover_and_avatar,
  });

  String? group_id;
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
  String? telephone;
  String? email;
  String? camera_url;
  String? group_date;
  String? status;
  String? school_id;
  String? category_name;
  bool? group_picture_default;
  String? i_joined;
  bool? i_admin;
  int? total_requests;
  bool? class_allow_post;
  bool? class_change_cover_and_avatar;
  factory InfoGroupDetails.fromJson(Map<String, dynamic>? json) {
    return InfoGroupDetails(
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
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
      telephone:
          json?["telephone"] == null ? null : json?['telephone'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      camera_url:
          json?["camera_url"] == null ? null : json?['camera_url'] as String,
      group_date:
          json?["group_date"] == null ? null : json?['group_date'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
      category_name: json?["category_name"] == null
          ? null
          : json?['category_name'] as String,
      group_picture_default: json?["group_picture_default"] == null
          ? null
          : json?['group_picture_default'] as bool,
      i_joined: json?["i_joined"] == null ? null : json?['i_joined'] as String,
      i_admin: json?["i_admin"] == null ? null : json?['i_admin'] as bool,
      total_requests: json?["total_requests"] == null
          ? null
          : json?['total_requests'] as int,
      class_allow_post: json?["class_allow_post"] == null
          ? null
          : json?['class_allow_post'] as bool,
      class_change_cover_and_avatar:
          json?["class_change_cover_and_avatar"] == null
              ? null
              : json?['class_change_cover_and_avatar'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "group_id": group_id,
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
        "telephone": telephone,
        "email": email,
        "camera_url": camera_url,
        "group_date": group_date,
        "status": status,
        "school_id": school_id,
        "category_name": category_name,
        "group_picture_default": group_picture_default,
        "i_joined": i_joined,
        "i_admin": i_admin,
        "total_requests": total_requests,
        "class_allow_post": class_allow_post,
        "class_change_cover_and_avatar": class_change_cover_and_avatar,
      };
}
