import 'package:mobiedu_kids/domain/entities/meal.dart';

class MealSchoolDetails {
  MealSchoolDetails({
        this.menu_id,
        this.menu_name,
        this.applied_for,
        this.begin,
        this.status,
        this.is_meal,
        this.is_saturday,
        this.is_notified,
        this.description,
        this.details,
        this.school_id,
        this.class_level_id,
        this.class_id,
        this.end,
        this.views_count,
        this.created_at,
        this.updated_at,
        this.created_user_id,
  });
  
        String?   menu_id;
        String?   menu_name;
        String?   applied_for;
        String?   begin;
        String?   status;
        String?   is_meal;
        String?   is_saturday;
        String?   is_notified;
        String?   description;
        List<Meal>? details;
        String? school_id;
        String? class_level_id;
        String? class_id;
        String? end;
        String? views_count;
        String? created_at;
        String? updated_at;
        String? created_user_id;

  factory MealSchoolDetails.fromJson(Map<String, dynamic>? json) {
    return MealSchoolDetails(
      menu_id: json?["menu_id"] == null
          ? null
          : json?['menu_id'] as String,
      menu_name: json?["menu_name"] == null
          ? null
          : json?['menu_name'] as String,
      applied_for: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
      begin: json?["begin"] == null
          ? null
          : json?['begin'] as String,
      status: json?["status"] == null
          ? null
          : json?['status'] as String,
      is_meal: json?["is_meal"] == null
          ? null
          : json?['is_meal'] as String,
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
          : List<Meal>.from(json?["details"].map((x) => Meal.fromJson(x))),
      school_id: json?["description"] == null
          ? null
          : json?['description'] as String,
            class_level_id: json?["description"] == null
          ? null
          : json?['description'] as String,
            class_id: json?["description"] == null
          ? null
          : json?['description'] as String,
            end: json?["description"] == null
          ? null
          : json?['description'] as String,
            views_count: json?["description"] == null
          ? null
          : json?['description'] as String,
            created_at: json?["description"] == null
          ? null
          : json?['description'] as String,
            updated_at: json?["description"] == null
          ? null
          : json?['description'] as String,
            created_user_id: json?["description"] == null
          ? null
          : json?['description'] as String, 
    );
  }

  Map<String, dynamic> toJson() => {
            "menu_id": menu_id,
            "menu_name": menu_name,
            "applied_for": applied_for,
            "begin": begin,
            "status": status,
            "is_meal": is_meal,
            "is_saturday": is_saturday,
            "is_notified": is_notified,
            "description": description,
            "details": details,
            "school_id": school_id,
            "class_level_id": class_level_id,
            "class_id": class_id,
            "end": end,
            "views_count": views_count,
            "created_at": created_at,
            "updated_at": updated_at,
            "created_user_id": created_user_id
  };     
}