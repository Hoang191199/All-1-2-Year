class Activity {
  Activity({
    this.schedule_detail_id,
    this.schedule_id,
    this.subject_name,
    this.subject_time,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

    String?  schedule_detail_id;
    String?  schedule_id;
    String?  subject_name;
    String?  subject_time;
    String?  monday;
    String?  tuesday;
    String?  wednesday;
    String?  thursday;
    String?  friday;
    String?  saturday;

  factory Activity.fromJson(Map<String, dynamic>? json) {
    return Activity(
      schedule_detail_id: json?["schedule_detail_id"] == null ? null : json?['schedule_detail_id'] as String,
      schedule_id: json?["schedule_id"] == null ? null : json?['schedule_id'] as String,
      subject_name: json?["subject_name"] == null ? null : json?['subject_name'] as String,
      subject_time: json?["subject_time"] == null ? null : json?['subject_time'] as String,
      monday: json?["monday"] == null ? null : json?['monday'] as String,
      tuesday: json?["tuesday"] == null ? null : json?['tuesday'] as String,
      wednesday: json?["wednesday"] == null ? null : json?['wednesday'] as String,
      thursday: json?["thursday"] == null ? null : json?['thursday'] as String,
      friday: json?["friday"] == null ? null : json?['friday'] as String,
      saturday: json?["saturday"] == null ? null : json?['saturday'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
                    "schedule_detail_id": schedule_detail_id,
                    "schedule_id": schedule_id,
                    "subject_name": subject_name,
                    "subject_time": subject_time,
                    "monday": monday,
                    "tuesday": tuesday,
                    "wednesday": wednesday,
                    "thursday": thursday,
                    "friday": friday,
                    "saturday": saturday
  };
}