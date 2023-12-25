import 'package:mobiedu_kids/domain/entities/attendance/detail.dart';

class AttendanceBack {
  AttendanceBack({
    this.detail,
    this.not_came_back_count,
    this.came_back_count,
  });
  
  List<Detail>? detail;
  String? not_came_back_count;
  String? came_back_count;

  factory AttendanceBack.fromJson(Map<String, dynamic>? json) {
    return AttendanceBack(
      detail:json?['detail'] == null ? null : List<Detail>.from(json?["detail"].map((x) => Detail.fromJson(x))),
      not_came_back_count: json?["not_came_back_count"] == null ? null : json?['not_came_back_count'] as String,
      came_back_count: json?["came_back_count"] == null ? null : json?['came_back_count'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'detail': detail,
    'not_came_back_count': not_came_back_count,
    'came_back_count': came_back_count,
  };
}
