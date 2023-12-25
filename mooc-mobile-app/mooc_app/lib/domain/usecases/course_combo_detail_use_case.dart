import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course_combo_detail.dart';
import 'package:mooc_app/domain/repositories/course_combo_repository.dart';

class CourseComboDetailUseCase
    extends ParamUseCase<CourseComboDetail, Tuple2<int, String>> {
  CourseComboDetailUseCase(this.courseRepository);

  final CourseComboRepository courseRepository;

  @override
  Future<CourseComboDetail> execute2(params) {
    return courseRepository.getCourseComboFullBySlug(params);
  }

  @override
  Future<CourseComboDetail> execute(Tuple2 params) {
    return courseRepository.getCourseComboDetail(params.value1, params.value2);
  }
}
