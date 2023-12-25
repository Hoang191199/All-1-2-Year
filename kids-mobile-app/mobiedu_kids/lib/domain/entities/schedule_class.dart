import 'package:mobiedu_kids/domain/entities/schedule_class_details.dart';

class ScheduleClass {
  ScheduleClass({
    this.schedule_class,
  });

  ScheduleClassDetails? schedule_class;
  factory ScheduleClass.fromJson(Map<String, dynamic>? json) {
    return ScheduleClass(
      schedule_class: json?["schedule_class"] == null
          ? null
          : ScheduleClassDetails.fromJson(json?['schedule_class']),
    );
  }

  Map<String, dynamic> toJson() => {
        'schedule_class': schedule_class,
      };
}
