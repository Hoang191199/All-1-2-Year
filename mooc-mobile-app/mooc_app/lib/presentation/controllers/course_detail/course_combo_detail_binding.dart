import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_combo_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_combo_detail_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_combo_detail_controller.dart';

class CourseComboDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseComboRepositoryImpl());
    Get.lazyPut(
        () => CourseComboDetailUseCase(Get.find<CourseComboRepositoryImpl>()));
    Get.lazyPut(() => CourseComboDetailController(Get.find()));
  }
}
