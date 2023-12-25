import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class LearningCourseListUseCase extends ParamUseCase<ResponseDataArrayObject<PaidCourseDetails>, Tuple2<int, int>> {
  LearningCourseListUseCase(this.courseRepository);

  final CourseRepository courseRepository;
  @override
  Future<ResponseDataArrayObject<PaidCourseDetails>> execute(Tuple2 params) {
    return courseRepository.fetchLearningCoursesList(params.value1, params.value2);
  }
}