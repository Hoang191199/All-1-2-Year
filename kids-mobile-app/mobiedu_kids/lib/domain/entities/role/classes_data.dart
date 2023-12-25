class ClassesData {
  ClassesData({
    this.school_status,
    this.page_title,
    this.page_picture,
    this.group_title,
    this.group_id,
    this.group_name,
    this.page_name
  });

  String? school_status;
  String? page_title;
  String? page_picture;
  String? group_title;
  String? group_id;
  String? group_name;
  String? page_name;

  factory ClassesData.fromJson(Map<String, dynamic>? json) {
    return ClassesData(
      school_status: json?["school_status"] == null ? null : json?['school_status'] as String,
      page_title:json?["page_title"] == null ? null : json?['page_title'] as String,
      page_picture:json?["page_picture"] == null ? null : json?['page_picture'] as String,
      group_title:json?["group_title"] == null ? null : json?['group_title'] as String,
      group_id:json?["group_id"] == null ? null : json?['group_id'] as String,
      group_name:json?["group_name"] == null ? null : json?['group_name'] as String,
      page_name:json?["page_name"] == null ? null : json?['page_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'school_status': school_status,
        'page_title': page_title,
        'page_picture': page_picture,
        'group_title': group_title,
        'group_id': group_id,
        'group_name': group_name,
        'page_name': page_name
      };
}
