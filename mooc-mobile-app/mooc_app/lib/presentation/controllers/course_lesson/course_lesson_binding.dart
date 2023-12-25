import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_lesson_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';

class CourseLessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseLessonUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseLessonController(Get.find()));
  }
  
}