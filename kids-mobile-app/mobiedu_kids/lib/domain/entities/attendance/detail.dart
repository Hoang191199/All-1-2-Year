import 'package:flutter/material.dart';
import 'package:mobiedu_kids/domain/entities/attendance/detail_temp.dart';

class Detail{
  Detail({
    this.child_id,
    this.child_name,
    this.child_picture,
    this.status,
    this.reason,
    this.attendance_detail_id,
    this.attendance_id,
    this.came_back_time,
    this.came_back_note,
    this.came_back_status,
    this.source_file,
    this.start_date,
    this.end_date,
    this.feedback
  });

  String? child_id;
  String? child_name;
  String? child_picture;
  dynamic status;
  String? reason;
  String? attendance_detail_id;
  String? attendance_id;
  String? came_back_time;
  String? came_back_note;
  String? came_back_status;
  String? source_file;
  String? start_date;
  String? end_date;
  String? feedback;

  factory Detail.fromJson(Map<String, dynamic>? json) {
    var status = json?['status'];

    if (status is String) {
    } else if (status is int) {
    }
    
    return Detail(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      child_picture: json?["child_picture"] == null ? null : json?['child_picture'] as String,
      status: status.toString(),
      reason: json?["reason"] == null ? null : json?['reason'] as String,
      attendance_detail_id: json?["attendance_detail_id"] == null ? null : json?['attendance_detail_id'] as String,
      attendance_id: json?["attendance_id"] == null ? null : json?['attendance_id'] as String,
      came_back_time: json?["came_back_time"] == null ? null : json?['came_back_time'] as String,
      came_back_note: json?["came_back_note"] == null ? null : json?['came_back_note'] as String,
      came_back_status: json?["came_back_status"] == null ? null : json?['came_back_status'] as String,
      source_file: json?["source_file"] == null ? null : json?['source_file'] as String,
      start_date: json?["start_date"] == null ? null : json?['start_date'] as String,
      end_date: json?["end_date"] == null ? null : json?['end_date'] as String,
      feedback: json?["feedback"] == null ? null : json?['feedback'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'child_id': child_id,
    'child_name': child_name,
    'child_picture': child_picture,
    'status': status,
    'reason': reason,
    'attendance_detail_id': attendance_detail_id,
    'attendance_id': attendance_id,
    'came_back_time': came_back_time,
    'came_back_note': came_back_note,
    'came_back_status': came_back_status,
    'source_file': source_file,
    'end_date': end_date,
    'start_date': start_date,
    'feedback': feedback
  };

  DetailTemp parseToDetailTemp({
    String? id,
    bool? check,
    int? permission,
    TextEditingController? reason,
    String? image,
    bool? show,
    String ? status_back,
    String? time_back,
    bool? check_back,
    TextEditingController? came_back_note,
    String? source_file,
    String? fileName
  }) {
    bool isShow = check ?? (status != '1');
    bool isChecked = check ?? (status == '1');
    bool isCheckedBack = check ?? (came_back_status == '1');
    int? parsedPermission = permission ?? (status != '1' ? int.parse(status) : 0);
    return DetailTemp(
      id: id ?? child_id,
      reason:  reason ?? TextEditingController(text: this.reason),
      check: check ?? isChecked,
      show: show ?? isShow,
      student: this,
      permission: parsedPermission,
      status: status,
      status_back : came_back_status,
      check_back: check_back ?? isCheckedBack,
      time_back: time_back ?? came_back_time,
      came_back_note:  came_back_note ?? TextEditingController(text: this.came_back_note),
      source_file: source_file ?? this.source_file,
      fileName: fileName
    );
  }
  
}