import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/course_review.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CourseReviewListUseCase extends ParamUseCase<ResponseDataObject<CourseReview>, int> {
  CourseReviewListUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseDataObject<CourseReview>> execute(int params) {
    return courseRepository.getCourseReviewList(params);
  }
}