class PageJoin {
  PageJoin({
    this.page_id,
    this.page_admin,
    this.page_category,
    this.page_name,
    this.page_title,
    this.page_description,
    this.page_picture,
    this.page_cover,
    this.page_likes,
    this.views_in_thirty_days,
    this.school_id,
    this.display_rate_school,
    this.total_review,
    this.average_review,
    this.i_like,
    this.i_admin,
    this.i_teacher,
    this.allow_review,
  });

  String? page_id;
  String? page_admin;
  String? page_category;
  String? page_name;
  String? page_title;
  String? page_description;
  String? page_picture;
  String? page_cover;
  String? page_likes;
  String? views_in_thirty_days;
  String? school_id;
  bool? display_rate_school;
  String? total_review;
  String? average_review;
  bool? i_like;
  bool? i_admin;
  bool? i_teacher;
  bool? allow_review;

  factory PageJoin.fromJson(Map<String, dynamic>? json) {
    return PageJoin(
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_admin: json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_category: json?["page_category"] == null ? null : json?['page_category'] as String,
      page_name: json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title: json?["page_title"] == null ? null : json?['page_title'] as String,
      page_description: json?["page_description"] == null ? null : json?['page_description'] as String,
      page_picture: json?["page_picture"] == null ? null : json?['page_picture'] as String,
      page_cover: json?["page_cover"] == null ? null : json?['page_cover'] as String,
      page_likes: json?["page_likes"] == null ? null : json?['page_likes'] as String,
      views_in_thirty_days: json?["views_in_thirty_days"] == null ? null : json?['views_in_thirty_days'].toString(),
      school_id: json?["school_id"] == null ? null : json?['school_id'] as String,
      display_rate_school: json?["display_rate_school"] == null ? false : json?['display_rate_school'] as bool,
      total_review: json?["total_review"] == null ? null : json?['total_review'].toString(),
      average_review: json?["average_review"] == null ? null : json?['average_review'].toString(),
      i_like: json?["i_like"] == null ? false : json?['i_like'] as bool,
      i_admin: json?["i_admin"] == null ? false : json?['i_admin'] as bool,
      i_teacher: json?["i_teacher"] == null ? false : json?['i_teacher'] as bool,
      allow_review: json?["allow_review"] == null ? false : json?['allow_review'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'page_id': page_id,
    'page_admin': page_admin,
    'page_category': page_category,
    'page_name': page_name,
    'page_title': page_title,
    'page_description': page_description,
    'page_picture': page_picture,
    'page_cover': page_cover,
    'page_likes': page_likes,
    'views_in_thirty_days': views_in_thirty_days,
    'school_id': school_id,
    'display_rate_school': display_rate_school,
    'total_review': total_review,
    'average_review': average_review,
    'i_like': i_like,
    'i_admin': i_admin,
    'i_teacher': i_teacher,
    'allow_review': allow_review,
  };
}