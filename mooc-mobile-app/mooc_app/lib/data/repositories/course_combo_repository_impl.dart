import 'package:mooc_app/data/models/course_combo_detail_model.dart';
import 'package:mooc_app/data/models/course_combo_paging_model.dart';
import 'package:mooc_app/data/providers/network/apis/course_combo_api.dart';
import 'package:mooc_app/domain/entities/course_combo_detail.dart';
import 'package:mooc_app/domain/entities/course_combo_paging.dart';
import 'package:mooc_app/domain/repositories/course_combo_repository.dart';

class CourseComboRepositoryImpl extends CourseComboRepository {
  @override
  Future<CourseComboPaging> fetchCoursesCombo(int page, int pageSize) async {
    final response =
        await CourseCombo.fetchCoursesCombo(page, pageSize).request();
    return CourseComboPagingModel.fromJson(response);
  }

  @override
  Future<CourseComboPaging> fetchCourseComboByKeyword(String keyword, int page, int pageSize) async {
    final response = await CourseCombo.fetchCourseComboByKeyword(keyword, page, pageSize).request();
    return CourseComboPagingModel.fromJson(response);
  }

  @override
  Future<CourseComboDetail> getCourseComboFullBySlug(String slug) async {
    final response = await CourseCombo.getCourseComboFullBySlug(slug).request();
    return CourseComboDetailModel.fromJson(response);
  }

  @override
  Future<CourseComboDetail> getCourseComboDetail(int id, String slug) async {
    final response = await CourseCombo.getCourseComboDetail(id, slug).request();
    return CourseComboDetailModel.fromJson(response);
  }

  // @override
  // Future<ResponseData> addFreeCourse(int idCourse) async {
  //   final response = await CourseCombo.addFreeCourse(idCourse).request();
  //   return ResponseData.fromJson(response);
  // }
}
