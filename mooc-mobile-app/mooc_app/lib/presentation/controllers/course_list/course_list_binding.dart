import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_list_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_controller.dart';

class CourseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseListUseCase(Get.find<CourseRepositoryImpl>(),Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseListController(Get.find(),Get.find()));
  }
  
}