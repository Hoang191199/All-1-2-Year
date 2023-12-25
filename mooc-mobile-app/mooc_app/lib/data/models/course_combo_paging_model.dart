import 'package:mooc_app/domain/entities/course_combo.dart';
import 'package:mooc_app/domain/entities/course_combo_paging.dart';

class CourseComboPagingModel extends CourseComboPaging {
  CourseComboPagingModel({
    required total,
    required item,
  }) : super(item: item, total: total);

  @override
  factory CourseComboPagingModel.fromJson(Map<String, dynamic> json) =>
      CourseComboPagingModel(
        total: json["total"] as int,
        item: List<CourseCombo>.from(
            json["item"].map((x) => CourseCombo.fromJson(x))),
      );
}
