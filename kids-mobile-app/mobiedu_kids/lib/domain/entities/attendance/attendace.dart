import 'package:mobiedu_kids/domain/entities/attendance/attendance_back.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendance_list.dart';

class Attendance {
  Attendance({
    this.attendance_back,
    this.attendance_list,
  });

  AttendanceBack? attendance_back;
  AttendanceList? attendance_list;

  factory Attendance.fromJson(Map<String, dynamic>? json) {
    return Attendance(
      attendance_back:json?['attendance_back'] == null ? null : AttendanceBack.fromJson(json?['attendance_back']),
      attendance_list:json?['attendance_list'] == null ? null : AttendanceList.fromJson(json?['attendance_list'])
    );
  }

  Map<String, dynamic> toJson() => {
    'attendance_back': attendance_back,
    'attendance_list': attendance_list
  };
}
