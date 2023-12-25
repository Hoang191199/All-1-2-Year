import 'package:mobiedu_kids/domain/entities/infomation/data_schedule.dart';

class ScheduleChild{
  ScheduleChild({
    this.schedule_child
  });

  DataSchedule? schedule_child;

  factory ScheduleChild.fromJson(Map<String, dynamic>? json) {
    return ScheduleChild(
       schedule_child:json?['schedule_child'] == null ? null : DataSchedule.fromJson(json?['schedule_child']),
    );
  }

  Map<String, dynamic> toJson() => {
    'schedule_child': schedule_child,
  };
}