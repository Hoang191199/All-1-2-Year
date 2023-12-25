import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course_combo_paging.dart';
import 'package:mooc_app/domain/repositories/course_combo_repository.dart';

class CourseComboUseCase
    extends ParamUseCase<CourseComboPaging, Tuple3<String, int, int>> {
  CourseComboUseCase(this.courseRepository, this.courseSearchData);

  final CourseComboRepository courseRepository;
  final CourseComboRepository courseSearchData;
  @override
  Future<CourseComboPaging> execute(Tuple3 params) {
    return courseRepository.fetchCoursesCombo(params.value2, params.value3);
  }
  
  @override
  Future<CourseComboPaging> execute2(Tuple3 params) {
    return courseSearchData.fetchCourseComboByKeyword(params.value1, params.value2, params.value3);
  }
}
