class ScheduleDetails<T> {
  ScheduleDetails({
    this.schedule_detail,
  });

  T? schedule_detail;
  factory ScheduleDetails.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ScheduleDetails(
      schedule_detail: json?["schedule_detail"] == null
          ? null
          : create(json?['schedule_detail']),
    );
  }

  Map<String, dynamic> toJson() => {
        'schedule_detail': schedule_detail,
      };
}
