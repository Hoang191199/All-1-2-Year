import 'package:mooc_app/domain/entities/course_combo.dart';

class CourseComboPaging {
  CourseComboPaging({
    required this.total,
    required this.item,
  });

  int total;
  List<CourseCombo> item;
}
