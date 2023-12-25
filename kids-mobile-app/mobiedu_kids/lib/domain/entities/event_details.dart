class EventDetails {
  EventDetails({
    this.event_id,
    this.event_name,
    this.level,
    this.must_register,
    this.registration_deadline,
    this.for_teacher,
    this.for_parent,
    this.for_child,
    this.parent_participants,
    this.child_participants,
    this.teacher_participants,
    this.post_on_wall,
    this.post_ids,
    this.is_notified,
    this.status,
    this.description,
    this.views_count,
    this.created_at,
    this.created_user_id,
    this.user_fullname,
    this.class_level_name,
    this.group_title,
    this.can_register,
    this.post_on_wall_text,
    this.is_notified_text,
    this.updated_at,
  });
  String? event_id;
  String? event_name;
  String? level;
  String? must_register;
  String? registration_deadline;
  String? for_teacher;
  String? for_parent;
  String? for_child;
  String? parent_participants;
  String? child_participants;
  String? teacher_participants;
  String? post_on_wall;
  String? post_ids;
  String? is_notified;
  String? status;
  String? description;
  String? views_count;
  String? created_at;
  String? created_user_id;
  String? user_fullname;
  String? class_level_name;
  String? group_title;
  int? can_register;
  String? post_on_wall_text;
  String? is_notified_text;
  String? updated_at;

  factory EventDetails.fromJson(Map<String, dynamic>? json) {
    return EventDetails(
        event_id:
            json?["event_id"] == null ? null : json?['event_id'] as String,
        event_name:
            json?["event_name"] == null ? null : json?['event_name'] as String,
        level: json?["level"] == null ? null : json?['level'] as String,
        must_register: json?["must_register"] == null
            ? null
            : json?['must_register'] as String,
        registration_deadline: json?["registration_deadline"] == null
            ? null
            : json?['registration_deadline'] as String,
        for_teacher: json?["for_teacher"] == null
            ? null
            : json?['for_teacher'] as String,
        for_parent:
            json?["for_parent"] == null ? null : json?['for_parent'] as String,
        for_child:
            json?["for_child"] == null ? null : json?['for_child'] as String,
        post_on_wall: json?["post_on_wall"] == null
            ? null
            : json?['post_on_wall'] as String,
        post_ids:
            json?["event_name"] == null ? null : json?['event_name'] as String,
        is_notified: json?["is_notified"] == null
            ? null
            : json?['is_notified'] as String,
        status: json?["status"] == null ? null : json?['status'] as String,
        description: json?["description"] == null
            ? null
            : json?['description'] as String,
        views_count: json?["views_count"] == null
            ? null
            : json?['views_count'] as String,
        created_user_id: json?["created_user_id"] == null
            ? null
            : json?['created_user_id'] as String,
        user_fullname: json?["created_user_id"] == null
            ? null
            : json?['created_user_id'] as String,
        class_level_name: json?["created_user_id"] == null
            ? null
            : json?['created_user_id'] as String,
        group_title: json?["created_user_id"] == null
            ? null
            : json?['created_user_id'] as String,
        can_register:
            json?["can_register"] == null ? null : json?['can_register'] as int,
        post_on_wall_text: json?["post_on_wall_text"] == null
            ? null
            : json?['post_on_wall_text'] as String,
        is_notified_text: json?["is_notified_text"] == null
            ? null
            : json?['is_notified_text'] as String);
  }

  Map<String, dynamic> toJson() => {
        "event_id": event_id,
        "event_name": event_name,
        "level": level,
        "must_register": must_register,
        "registration_deadline": registration_deadline,
        "for_teacher": for_teacher,
        "for_parent": for_parent,
        "for_child": for_child,
        "parent_participants": parent_participants,
        "child_participants": child_participants,
        "teacher_participants": teacher_participants,
        "post_on_wall": post_on_wall,
        "post_ids": post_ids,
        "is_notified": is_notified,
        "status": status,
        "description": description,
        "created_at": created_at,
        "created_user_id": created_user_id,
        "user_fullname": user_fullname,
        "class_level_name": class_level_name,
        "group_title": group_title,
        "can_register": can_register,
        "updated_at": updated_at
      };
}
