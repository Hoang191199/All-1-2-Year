import 'package:mobiedu_kids/domain/entities/attendance/attendance_class_data.dart';

class AttendenceClass {
  AttendenceClass({
    this.group_name,
    this.attendance_class,
  });
  
  AttendenceClassData? attendance_class;
  String? group_name;

  factory AttendenceClass.fromJson(Map<String, dynamic>? json) {
    return AttendenceClass(
      attendance_class:json?['attendance_class'] == null ? null : AttendenceClassData.fromJson(json?["attendance_class"]),
      group_name: json?["group_name"] == null ? null : json?['group_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'attendance_class': attendance_class,
    'group_name': group_name
  };
}