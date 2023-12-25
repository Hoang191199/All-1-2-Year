import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/active_course_use_case.dart';
import 'package:mooc_app/presentation/controllers/active_course/active_course_controller.dart';

class ActiveCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => ActiveCourseUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => ActiveCourseController(Get.find()));
  }
  
}