import 'package:mobiedu_kids/domain/entities/schedule_list.dart';

class Schedule {
  Schedule({
    this.schedules,
  });

  List<ScheduleData>? schedules;

  factory Schedule.fromJson(Map<String, dynamic>? json) {
    return Schedule(
      schedules: json?["schedules"] == null ? null : List<ScheduleData>.from(json?["schedules"].map((x) => ScheduleData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'schedules': schedules,
      };
}
