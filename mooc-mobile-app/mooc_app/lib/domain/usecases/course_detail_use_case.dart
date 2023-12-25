import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseDetailUseCase extends ParamUseCase<ResponseDataObject<Course>, Tuple2<int, String>> {
  CourseDetailUseCase(this.courseRepository);

  final CourseRepository courseRepository;
  
  @override
  Future<ResponseDataObject<Course>> execute(Tuple2 params) {
    return courseRepository.getCourseFullByIdSlug(params.value1, params.value2);
  }
  
}