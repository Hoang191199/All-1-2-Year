import 'package:mobiedu_kids/domain/entities/activity.dart';

class ScheduleMoreDetails {
  ScheduleMoreDetails({
        this.schedule_id,
        this.schedule_name,
        this.applied_for,
        this.begin,
        this.status,
        this.is_category,
        this.is_saturday,
        this.is_notified,
        this.description,
        this.details,
        this.level,
  });
  
        String?   schedule_id;
        String?   schedule_name;
        String?   applied_for;
        String?   begin;
        String?   status;
        String?   is_category;
        String?   is_saturday;
        String?   is_notified;
        String?   description;
        List<Activity>? details;
        String?   level;
  factory ScheduleMoreDetails.fromJson(Map<String, dynamic>? json) {
    return ScheduleMoreDetails(
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
      is_category: json?["is_category"] == null
          ? null
          : json?['is_category'] as String,
      is_saturday: json?["is_saturday"] == null
          ? null
          : json?['is_saturday'] as String,
      is_notified: json?["is_notified"] == null
          ? null
          : json?['is_notified'] as String,
      description: json?["description"] == null
          ? null
          : json?['description'] as String,
      details: json?["details"] == null
          ? null
          : List<Activity>.from(json?["details"].map((x) => Activity.fromJson(x))),
      level: json?["level"] == null
          ? null
          : json?['level'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
            "schedule_id": schedule_id,
            "schedule_name": schedule_name,
            "applied_for": applied_for,
            "begin": begin,
            "status": status,
            "is_category": is_category,
            "is_saturday": is_saturday,
            "is_notified": is_notified,
            "description": description,
            "details": details,
            "level": level,
      };
}
