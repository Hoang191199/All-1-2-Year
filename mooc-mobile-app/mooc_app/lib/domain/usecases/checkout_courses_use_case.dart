import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CheckoutCoursesUseCase extends ParamUseCase<ResponseData, Tuple8<String, String, String, String, String, List<int>, int, String> > {
  CheckoutCoursesUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseData> execute(Tuple8 params) {
    return courseRepository.checkoutCourses(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6, params.value7, params.value8);
  }
  
}