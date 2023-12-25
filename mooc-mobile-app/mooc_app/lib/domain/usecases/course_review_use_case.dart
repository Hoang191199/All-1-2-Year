import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseReviewUseCase extends ParamUseCase<ResponseData, Tuple3<int, int, String>> {
  CourseReviewUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseData> execute(Tuple3 params) {
    return courseRepository.sendCourseReview(params.value1, params.value2, params.value3);
  }
}