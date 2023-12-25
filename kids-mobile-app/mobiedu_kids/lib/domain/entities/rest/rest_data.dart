import 'package:mobiedu_kids/domain/entities/rest/list_attendance.dart';

class RestData {
  RestData({
    this.absence_count,
    this.attendance
  });
  int? absence_count;
  List<ListAttendance>? attendance;

  factory RestData.fromJson(Map<String, dynamic>? json) {
  return RestData(
    absence_count: json?["absence_count"] == null ? null : json?['absence_count'] as int,
    attendance: json?['attendance'] == null ? null : List<ListAttendance>.from(json?["attendance"].map((x) => ListAttendance.fromJson(x))),
  );
  }

  Map<String, dynamic> toJson() => {
    'absence_count': absence_count,
    'attendance': attendance
  };

}