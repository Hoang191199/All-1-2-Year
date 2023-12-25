// import 'package:mooc_app/domain/entities/course_detail.dart';
import 'package:mooc_app/domain/entities/course_combo_detail.dart';
import 'package:mooc_app/domain/entities/course_combo_paging.dart';

abstract class CourseComboRepository {
  Future<CourseComboPaging> fetchCoursesCombo(int page, int pageSize);
  Future<CourseComboDetail> getCourseComboFullBySlug(String slug);
  Future<CourseComboDetail> getCourseComboDetail(int id, String slug);
  Future<CourseComboPaging> fetchCourseComboByKeyword(String keyword, int page, int pageSize);
  // Future<ResponseData> addFreeCourse(int idCourse);
  // Future<ResponseData> activeCourse(String activeCode);
}
