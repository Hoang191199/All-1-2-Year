import 'package:mooc_app/domain/entities/course_combo.dart';
import 'package:mooc_app/domain/entities/course_combo_detail.dart';

class CourseComboDetailModel extends CourseComboDetail {
  CourseComboDetailModel({
    error,
    required data,
  }) : super(error: error, data: data);

  @override
  factory CourseComboDetailModel.fromJson(Map<String, dynamic> json) =>
      CourseComboDetailModel(
        error: json['error'] == null ? null : json["error"] as bool,
        data: json['data'] == null ? null : CourseCombo.fromJson(json['data']),
      );
}
