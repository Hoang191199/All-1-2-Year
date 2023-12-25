
class MenuHistoryDetails {
  MenuHistoryDetails({
        this.class_level_id,
        this.class_id,
        this.menu_id,
        this.menu_name,
        this.applied_for,
        this.begin,
        this.status,
        this.description,
        this.level,
        this.use,
  });

        String?   class_level_id;
        String?   class_id;
        String?   menu_id;
        String?   menu_name;
        String?   applied_for;
        String?   begin;
        String?   status;
        String?   description;
        String?   level;
        int? use;
  factory MenuHistoryDetails.fromJson(Map<String, dynamic>? json) {
    return MenuHistoryDetails(
      class_level_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
      class_id: json?["schedule_id"] == null
          ? null
          : json?['schedule_id'] as String,
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
            "menu_id": menu_id,
            "menu_name": menu_name,
            "applied_for": applied_for,
            "begin": begin,
            "status": status,
            "description": description,
            "level": level,
            "use": use
      };
}
