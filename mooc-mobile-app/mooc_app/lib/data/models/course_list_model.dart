import 'package:mooc_app/domain/entities/course.dart';

import '../../domain/entities/course_list.dart';

class CourseListModel extends CourseList {
  CourseListModel({
    required status,
    data,
  }) : super(status: status, data: data);

  @override
  factory CourseListModel.fromJson(Map<String, dynamic> json) =>
      CourseListModel(
        status: json["status"] as bool,
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
      );
}