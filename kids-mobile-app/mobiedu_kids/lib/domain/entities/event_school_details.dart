class EventsSchoolDetails {
  EventsSchoolDetails({
                this.event_id,
                this.event_name,
                this.must_register,
                this.registration_deadline,
                this.for_teacher,
                this.for_parent,
                this.for_child,
                this.post_on_wall,
                this.is_notified,
                this.status,
                this.description,
                this.views_count,
                this.created_user_id,
                this.class_level_name,
                this.group_title,
                this.can_register,
  });
                String? event_id;
                String? event_name;
                String? must_register;
                String? registration_deadline;
                String? for_teacher;
                String? for_parent;
                String? for_child;
                String? post_on_wall;
                String? is_notified;
                String? status;
                String? description;
                String? views_count;
                String? created_user_id;
                String? class_level_name;
                String? group_title;
                int? can_register;

  factory EventsSchoolDetails.fromJson(Map<String, dynamic>? json) {
    return EventsSchoolDetails(
      event_id: json?["event_id"] == null
          ? null
          : json?['event_id'] as String,
      event_name: json?["event_name"] == null
          ? null
          : json?['event_name'] as String,
      must_register: json?["must_register"] == null
          ? null
          : json?['must_register'] as String,
      registration_deadline: json?["registration_deadline"] == null
          ? null
          : json?['registration_deadline'] as String,
      for_teacher: json?["for_teacher"] == null
          ? null
          : json?['for_teacher'] as String,
      for_parent: json?["for_parent"] == null
          ? null
          : json?['for_parent'] as String,
      for_child: json?["for_child"] == null
          ? null
          : json?['for_child'] as String,
      post_on_wall: json?["post_on_wall"] == null
          ? null
          : json?['post_on_wall'] as String,
      is_notified: json?["is_notified"] == null
          ? null
          : json?['is_notified'] as String,
      status: json?["status"] == null
          ? null
          : json?['status'] as String,
      description: json?["description"] == null
          ? null
          : json?['description'] as String,
      views_count: json?["views_count"] == null
          ? null
          : json?['views_count'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      class_level_name: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      group_title: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      can_register: json?["can_register"] == null
          ? null
          : json?['can_register'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
            "event_id": event_id,
            "event_name": event_name,
            "must_register": must_register,
            "registration_deadline": registration_deadline,
            "for_teacher": for_teacher,
            "for_parent": for_parent,
            "for_child": for_child,
            "post_on_wall": post_on_wall,
            "is_notified": is_notified,
            "status": status,
            "description": description,
            "created_user_id": created_user_id,
            "class_level_name": class_level_name,
            "group_title": group_title,
            "can_register": can_register,
            "views_count": views_count,
      };
}