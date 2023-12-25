import 'package:mobiedu_kids/domain/entities/schedule_history_details.dart';

class ScheduleHistory {
  ScheduleHistory({
    this.schedule_history,
  });

  List<ScheduleHistoryDetails>? schedule_history;
  factory ScheduleHistory.fromJson(Map<String, dynamic>? json) {
    return ScheduleHistory(
      schedule_history: json?["schedule_history"] == null
          ? null
          : List<ScheduleHistoryDetails>.from(json?["schedule_history"]
              .map((x) => ScheduleHistoryDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'schedule_history': schedule_history,
      };
}
