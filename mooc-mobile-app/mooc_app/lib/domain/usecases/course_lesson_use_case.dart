import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/complete_lesson_response_data.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseLessonUseCase extends ParamUseCase<ResponseDataObject<CompleteLessonResponseData>, Tuple3<int, int, int>> {
  CourseLessonUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseDataObject<CompleteLessonResponseData>> execute(Tuple3 params) {
    return courseRepository.completeLesson(params.value1, params.value2, params.value3);
  }
  
}