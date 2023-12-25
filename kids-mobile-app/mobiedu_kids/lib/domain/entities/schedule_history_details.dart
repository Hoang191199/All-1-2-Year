
class ScheduleHistoryDetails {
  ScheduleHistoryDetails({
        this.class_level_id,
        this.class_id,
        this.schedule_id,
        this.schedule_name,
        this.applied_for,
        this.begin,
        this.status,
        this.description,
        this.level,
        this.use,
  });

        String?   class_level_id;
        String?   class_id;
        String?   schedule_id;
        String?   schedule_name;
        String?   applied_for;
        String?   begin;
        String?   status;
        String?   description;
        String?   level;
        int? use;
  factory ScheduleHistoryDetails.fromJson(Map<String, dynamic>? json) {
    return ScheduleHistoryDetails(
      class_level_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
      class_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
      schedule_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
      schedule_name: json?["schedule_name"] == null
          ? null
          : json?['schedule_name'] as String,
      applied_for: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
      begin: json?["begin"] == null
          ? null
          : json?['begin'] as String,
      status: json?["status"] == null
          ? null
          : json?['status'] as String,
      description: json?["description"] == null
          ? null
          : json?['description'] as String,
      level: json?["level"] == null
          ? null
          : json?['level'] as String,
      use: json?["use"] == null
          ? null
          : json?['use'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
            "class_level_id": class_level_id,
            "class_id": class_id,
            "schedule_id": schedule_id,
            "schedule_name": schedule_name,
            "applied_for": applied_for,
            "begin": begin,
            "status": status,
            "description": description,
            "level": level,
            "use": use
      };
}
