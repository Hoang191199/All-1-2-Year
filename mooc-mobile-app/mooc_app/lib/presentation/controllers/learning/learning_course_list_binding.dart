import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/learning_course_list_use_case.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';

class LearningCourseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => LearningCourseListUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => LearningCourseListController(Get.find()));
  }
  
}