import 'package:mobiedu_kids/domain/entities/attendance/detail.dart';

class AttendanceList {
  AttendanceList({
    this.absence_count,
    this.present_count,
    this.attendance_id,
    this.detail,
  });

  dynamic absence_count;
  dynamic present_count;
  String? attendance_id;
  List<Detail>? detail;

  factory AttendanceList.fromJson(Map<String, dynamic>? json) {
    var absenceCount = json?['absence_count'];
    var presentCount = json?['present_count'];

    if (absenceCount is String) {
    } else if (absenceCount is int) {
    }
    if (presentCount is String) {
    } else if (presentCount is int) {
    }

    return AttendanceList(
      absence_count: absenceCount?.toString(),
      present_count: presentCount?.toString(),
      attendance_id: json?["attendance_id"] == null ? null : json?['attendance_id'] as String,
      detail:json?['detail'] == null ? null : List<Detail>.from(json?["detail"].map((x) => Detail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'attendance_id': attendance_id,
    'present_count': present_count,
    'absence_count': absence_count,
    'detail': detail,
  };
}
