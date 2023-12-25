class MutualFriend {
  MutualFriend({
    this.school_status,
    this.page_title,
    this.page_picture,
    this.group_title,
  });

  String? school_status;
  String? page_title;
  String? page_picture;
  String? group_title;

  factory MutualFriend.fromJson(Map<String, dynamic>? json) {
    return MutualFriend(
      school_status: json?["school_status"] == null
          ? null
          : json?['school_status'] as String,
      page_title:
          json?["page_title"] == null ? null : json?['page_title'] as String,
      page_picture: json?["page_picture"] == null
          ? null
          : json?['page_picture'] as String,
      group_title:
          json?["group_title"] == null ? null : json?['group_title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'school_status': school_status,
        'page_title': page_title,
        'page_picture': page_picture,
        'group_title': group_title,
      };
}
