import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseRecommendUseCase extends ParamUseCase<CoursePaging, Tuple2<int, int>> {
  CourseRecommendUseCase(this.courseRepository);

  final CourseRepository courseRepository;
  
  @override
  Future<CoursePaging> execute(Tuple2 params) {
    return courseRepository.fetchCoursesRecommend(params.value1, params.value2);
  }
}