import 'package:mooc_app/domain/entities/course_combo.dart';

class CourseComboDetail {
  CourseComboDetail({
    this.error,
    required this.data,
  });

  bool? error;
  CourseCombo? data;
}
