import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class AddFreeCourseUseCase extends ParamUseCase<ResponseData, Tuple2<String, int> > {
  AddFreeCourseUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseData> execute(Tuple2 params) {
    if (params.value1 == 'course') {
      return courseRepository.addFreeCourse(params.value2);
    }
    if(params.value1 == 'package') {
      return courseRepository.addFreePackage(params.value2);
    }
    return courseRepository.addFreeCourse(params.value2);
  }
  
}