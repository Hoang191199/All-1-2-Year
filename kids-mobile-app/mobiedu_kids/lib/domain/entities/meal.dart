class Meal {
  Meal({
    this.menu_detail_id,
    this.menu_id,
    this.meal_name,
    this.meal_time,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

    String?  menu_detail_id;
    String?  menu_id;
    String?  meal_name;
    String?  meal_time;
    String?  monday;
    String?  tuesday;
    String?  wednesday;
    String?  thursday;
    String?  friday;
    String?  saturday;

  factory Meal.fromJson(Map<String, dynamic>? json) {
    return Meal(
      menu_detail_id: json?["menu_detail_id"] == null ? null : json?['menu_detail_id'] as String,
      menu_id: json?["menu_id"] == null ? null : json?['menu_id'] as String,
      meal_name: json?["meal_name"] == null ? null : json?['meal_name'] as String,
      meal_time: json?["meal_time"] == null ? null : json?['meal_time'] as String,
      monday: json?["monday"] == null ? null : json?['monday'] as String,
      tuesday: json?["tuesday"] == null ? null : json?['tuesday'] as String,
      wednesday: json?["wednesday"] == null ? null : json?['wednesday'] as String,
      thursday: json?["thursday"] == null ? null : json?['thursday'] as String,
      friday: json?["friday"] == null ? null : json?['friday'] as String,
      saturday: json?["saturday"] == null ? null : json?['saturday'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
                    "menu_detail_id": menu_detail_id,
                    "menu_id": menu_id,
                    "meal_name": meal_name,
                    "meal_time": meal_time,
                    "monday": monday,
                    "tuesday": tuesday,
                    "wednesday": wednesday,
                    "thursday": thursday,
                    "friday": friday,
                    "saturday": saturday,
  };
}