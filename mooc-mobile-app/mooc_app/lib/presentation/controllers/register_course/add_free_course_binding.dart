import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/add_free_course_use_case.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_controller.dart';

class AddFreeCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => AddFreeCourseUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => AddFreeCourseController(Get.find()));
  }
  
}