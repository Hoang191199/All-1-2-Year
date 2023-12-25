import 'package:mobiedu_kids/domain/entities/attendance/detail.dart';

class AttendenceClassData {
  AttendenceClassData({
    this.detail,
    this.attendace_id,
    this.is_checked,
  });
  
  List<Detail>? detail;
  String? attendace_id;
  String? is_checked;

  factory AttendenceClassData.fromJson(Map<String, dynamic>? json) {
    return AttendenceClassData(
      detail:json?['detail'] == null ? null : List<Detail>.from(json?["detail"].map((x) => Detail.fromJson(x))),
      attendace_id: json?["attendace_id"] == null ? null : json?['attendace_id'] as String,
      is_checked: json?["is_checked"] == null ? null : json?['is_checked'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'detail': detail,
    'attendace_id': attendace_id,
    'is_checked': is_checked,
  };
}