class FeedBacksDetails {
  FeedBacksDetails(
      {this.feedback_id,
      this.school_id,
      this.class_id,
      this.child_id,
      this.name,
      this.email,
      this.phone,
      this.content,
      this.level,
      this.is_incognito,
      this.confirm,
      this.status,
      this.created_at,
      this.updated_at,
      this.created_user_id,
      this.group_title,
      this.child_name});

  String? feedback_id;
  String? school_id;
  String? class_id;
  String? child_id;
  String? name;
  String? email;
  String? phone;
  String? content;
  String? level;
  String? is_incognito;
  String? confirm;
  String? status;
  String? created_at;
  String? updated_at;
  String? created_user_id;
  String? group_title;
  String? child_name;

  factory FeedBacksDetails.fromJson(Map<String, dynamic>? json) {
    return FeedBacksDetails(
      feedback_id:
          json?["feedback_id"] == null ? null : json?['feedback_id'] as String,
      school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
      class_id: json?["class_id"] == null ? null : json?['class_id'] as String,
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      name: json?["name"] == null ? null : json?['name'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      phone: json?["phone"] == null ? null : json?['phone'] as String,
      content: json?["content"] == null ? null : json?['content'] as String,
      level: json?["level"] == null ? null : json?['level'] as String,
      is_incognito: json?["is_incognito"] == null
          ? null
          : json?['is_incognito'] as String,
      confirm: json?["confirm"] == null ? null : json?['confirm'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      created_at:
          json?["created_at"] == null ? null : json?['created_at'] as String,
      updated_at:
          json?["updated_at"] == null ? null : json?['updated_at'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      group_title:
          json?["group_title"] == null ? null : json?['group_title'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "feedback_id": feedback_id,
        "school_id": school_id,
        "class_id": class_id,
        "child_id": child_id,
        "name": name,
        "email": email,
        "phone": phone,
        "content": content,
        "level": level,
        "is_incognito": is_incognito,
        "confirm": confirm,
        "status": status,
        "created_at": created_at,
        "updated_at": updated_at,
        "created_user_id": created_user_id,
        "group_title": group_title,
        "child_name": child_name
      };
}
