import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_combo_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_combo_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_combo_controller.dart';

class CourseComboBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseComboRepositoryImpl());
    Get.lazyPut(
        () => CourseComboUseCase(Get.find<CourseComboRepositoryImpl>(),Get.find<CourseComboRepositoryImpl>()));
    Get.lazyPut(() => CourseComboController(Get.find(), Get.find()));
  }
}
