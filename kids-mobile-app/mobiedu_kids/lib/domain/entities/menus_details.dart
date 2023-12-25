class MenusDetails {
  MenusDetails({
    this.menu_id,
    this.menu_name,
    this.begin,
    this.applied_for,
    this.school_id,
    this.class_level_id,
    this.class_id,
    this.is_notified
  });

    String? menu_id;
    String? menu_name;
    String? begin;
    String? applied_for;
    String? school_id;
    String? class_level_id;
    String? class_id;
    String? is_notified;

  factory MenusDetails.fromJson(Map<String, dynamic>? json) {
    return MenusDetails(
      menu_id: json?["menu_id"] == null
          ? null
          : json?['menu_id'] as String,
                menu_name: json?["menu_name"] == null
          ? null
          : json?['menu_name'] as String,
                begin: json?["begin"] == null
          ? null
          : json?['begin'] as String,
                applied_for: json?["applied_for"] == null
          ? null
          : json?['applied_for'] as String,
                school_id: json?["school_id"] == null
          ? null
          : json?['school_id'] as String,
                class_level_id: json?["class_level_id"] == null
          ? null
          : json?['class_level_id'] as String,
                class_id: json?["class_id"] == null
          ? null
          : json?['class_id'] as String,
                is_notified: json?["is_notified"] == null
          ? null
          : json?['is_notified'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "menu_id": menu_id,
                "menu_name": menu_name,
                "begin": begin,
                "applied_for": applied_for,
                "school_id": school_id,
                "class_level_id": class_level_id,
                "class_id": class_id,
                "is_notified": is_notified
      };
}