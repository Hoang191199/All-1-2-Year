import 'package:mooc_app/domain/entities/course.dart';

class CourseList {
  CourseList({
  required this.status,
  this.data,
  });

  bool status;
  List<Course>? data;
}
