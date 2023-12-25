import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseListUseCase extends ParamUseCase<CoursePaging, Tuple3<String, int, int>> {
  CourseListUseCase(this.courseRepository, this.coursekwRepository);

  final CourseRepository courseRepository;
  final CourseRepository coursekwRepository;
  @override
  Future<CoursePaging> execute(Tuple3 params) {
    if (params.value1 == Feature.featureSaleOff) {
      return courseRepository.fetchCoursesIsSale(params.value2, params.value3);
    }
    return courseRepository.fetchCoursesByCategory(params.value1, params.value2, params.value3);
  }

  Future<CoursePaging> execute2(Tuple3 params) {
    return coursekwRepository.fetchCoursesByKeyword(params.value1, params.value2, params.value3);
  }
}