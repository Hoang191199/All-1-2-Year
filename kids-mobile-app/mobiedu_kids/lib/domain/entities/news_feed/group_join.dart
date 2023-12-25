class GroupJoin {
  GroupJoin({
    this.group_id,
    this.group_admin,
    this.group_category,
    this.group_name,
    this.group_title,
    this.group_description,
    this.group_picture,
    this.group_cover,
    this.group_members,
    this.status,
    this.i_joined,
    this.i_admin,
    this.class_allow_post,
    this.class_change_cover_and_avatar,
  });

  String? group_id;
  String? group_admin;
  String? group_category;
  String? group_name;
  String? group_title;
  String? group_description;
  String? group_picture;
  String? group_cover;
  String? group_members;
  String? status;
  String? i_joined;
  bool? i_admin;
  bool? class_allow_post;
  bool? class_change_cover_and_avatar;

  factory GroupJoin.fromJson(Map<String, dynamic>? json) {
    return GroupJoin(
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      group_admin: json?["group_admin"] == null ? null : json?['group_admin'] as String,
      group_category: json?["group_category"] == null ? null : json?['group_category'] as String,
      group_name: json?["group_name"] == null ? null : json?['group_name'] as String,
      group_title: json?["group_title"] == null ? null : json?['group_title'] as String,
      group_description: json?["group_description"] == null ? null : json?['group_description'] as String,
      group_picture: json?["group_picture"] == null ? null : json?['group_picture'] as String,
      group_cover: json?["group_cover"] == null ? null : json?['group_cover'] as String,
      group_members: json?["group_members"] == null ? null : json?['group_members'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      i_joined: json?["i_joined"] == null ? null : json?['i_joined'].toString(),
      i_admin: json?["i_admin"] == null ? false : json?['i_admin'] as bool,
      class_allow_post: json?["class_allow_post"] == null ? false : json?['class_allow_post'] as bool,
      class_change_cover_and_avatar: json?["class_change_cover_and_avatar"] == null ? false : json?['class_change_cover_and_avatar'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'group_id': group_id,
    'group_admin': group_admin,
    'group_category': group_category,
    'group_name': group_name,
    'group_title': group_title,
    'group_description': group_description,
    'group_picture': group_picture,
    'group_cover': group_cover,
    'group_members': group_members,
    'status': status,
    'i_joined': i_joined,
    'i_admin': i_admin,
    'class_allow_post': class_allow_post,
    'class_change_cover_and_avatar': class_change_cover_and_avatar,
  };
}