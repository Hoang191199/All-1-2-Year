import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_review_list_use_case.dart';
import 'package:mooc_app/domain/usecases/course_review_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_controller.dart';

class CourseReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseReviewListUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseReviewUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseReviewController(Get.find(), Get.find()));
  }
  
}