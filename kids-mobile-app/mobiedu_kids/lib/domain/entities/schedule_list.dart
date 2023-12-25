class ScheduleData {
  ScheduleData({
    this.schedule_id,
    this.schedule_name,
    this.begin,
    this.applied_for,
    this.school_id,
    this.class_level_id,
    this.class_id,
    this.is_notified,
  });

    String? schedule_id;
    String? schedule_name;
    String? begin;
    String? applied_for;
    String? school_id;
    String? class_level_id;
    String? class_id;
    String? is_notified;

  factory ScheduleData.fromJson(Map<String, dynamic>? json) {
    return ScheduleData(
        schedule_id: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        schedule_name: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        begin: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        applied_for: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        school_id: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        class_level_id: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        class_id: json?["schedule_id"] == null
         ? null
         : json?['schedule_id'] as String,
        is_notified: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "schedule_id": schedule_id,
        "schedule_name": schedule_name,
        "begin": begin,
        "applied_for": applied_for,
        "school_id": school_id,
        "class_level_id": class_level_id,
        "class_id": class_id,
        "is_notified": is_notified
      };
}