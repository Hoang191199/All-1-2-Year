import 'package:mobiedu_kids/domain/entities/activity.dart';

class ScheduleSchoolDetails {
  ScheduleSchoolDetails({
        this.schedule_id,
        this.schedule_name,
        this.applied_for,
        this.school_id,
        this.class_level_id,
        this.class_id,
        this.begin,
        this.end,
        this.status,
        this.is_category,
        this.is_saturday,
        this.is_notified,
        this.description,
        this.details,
        this.views_count,
        this.created_at,
        this.updated_at,
        this.created_user_id,
        this.level,
  });
  
        String?   schedule_id;
        String?   schedule_name;
        String?   applied_for;
        String?   school_id;
        String?   class_level_id;
        String?   class_id;
        String?   begin;
        String?   end;
        String?   status;
        String?   is_category;
        String?   is_saturday;
        String?   is_notified;
        String?   description;
        List<Activity>? details;
        String?  views_count;
        String? created_at;
        String? updated_at;
        String? created_user_id;
        String?   level;
  factory ScheduleSchoolDetails.fromJson(Map<String, dynamic>? json) {
    return ScheduleSchoolDetails(
      schedule_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
      schedule_name: json?["schedule_name"] == null
          ? null
          : json?['schedule_name'] as String,
      applied_for: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
      school_id: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
            class_level_id: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
            class_id: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
      begin: json?["begin"] == null
          ? null
          : json?['begin'] as String,
          end: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
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
      views_count: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
            created_at: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
            updated_at: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
            created_user_id: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,  
      level: json?["level"] == null
          ? null
          : json?['level'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
            "schedule_id": schedule_id,
            "schedule_name": schedule_name,
            "applied_for": applied_for,
            "school_id": school_id,
            "class_level_id": class_level_id,
            "class_id": class_id,
            "begin": begin,
            "end": end,
            "status": status,
            "is_category": is_category,
            "is_saturday": is_saturday,
            "is_notified": is_notified,
            "description": description,
            "details": details,
            "views_count": views_count,
            "created_at": created_at,
            "updated_at": updated_at,
            "created_user_id": created_user_id,
            "level": level,
      };
}
