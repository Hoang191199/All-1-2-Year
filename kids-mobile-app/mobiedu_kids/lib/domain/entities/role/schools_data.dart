class SchoolsData {
  SchoolsData(
      {this.role_id,
      this.is_admin,
      this.page_title,
      this.page_picture,
      this.page_name});

  String? role_id;
  bool? is_admin;
  String? page_title;
  String? page_picture;
  String? page_name;

  factory SchoolsData.fromJson(Map<String, dynamic>? json) {
    return SchoolsData(
      role_id: json?["role_id"] == null ? null : json?['role_id'] as String,
      is_admin: json?["is_admin"] == null ? null : json?['is_admin'] as bool,
      page_title:
          json?["page_title"] == null ? null : json?['page_title'] as String,
      page_picture: json?["page_picture"] == null
          ? null
          : json?['page_picture'] as String,
      page_name:
          json?["page_name"] == null ? null : json?['page_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'role_id': role_id,
        'page_title': page_title,
        'page_picture': page_picture,
        'page_name': page_name
      };
}
