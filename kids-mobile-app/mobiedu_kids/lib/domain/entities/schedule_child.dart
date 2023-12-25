import 'package:mobiedu_kids/domain/entities/schedule_class_details.dart';

class ScheduleChild {
  ScheduleChild({
    this.schedule_child,
  });

  ScheduleClassDetails? schedule_child;
  factory ScheduleChild.fromJson(Map<String, dynamic>? json) {
    return ScheduleChild(
      schedule_child: json?["schedule_child"] == null
          ? null
          : ScheduleClassDetails.fromJson(json?['schedule_child']),
    );
  }

  Map<String, dynamic> toJson() => {
        'schedule_child': schedule_child,
      };
}
