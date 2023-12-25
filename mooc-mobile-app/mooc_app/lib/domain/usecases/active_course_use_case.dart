import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class ActiveCourseUseCase extends ParamUseCase<ResponseData, String> {
  ActiveCourseUseCase(this.courseRepository);

  final CourseRepository courseRepository;
  @override
  Future<ResponseData> execute(String params) {
    return courseRepository.activeCourse(params);
  }
  
}