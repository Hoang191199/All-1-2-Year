import 'package:mobiedu_kids/domain/entities/meal.dart';

class MealDetails {
  MealDetails({
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
  factory MealDetails.fromJson(Map<String, dynamic>? json) {
    return MealDetails(
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
      };
}
