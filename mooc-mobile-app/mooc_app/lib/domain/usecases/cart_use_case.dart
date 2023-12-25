import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CartUseCase extends ParamUseCase<ResponseDataArrayObject<Course>, List<int>> {
  CartUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseDataArrayObject<Course>> execute(List<int> params) {
    return courseRepository.fetchCoursesByIds(params);
  }
}