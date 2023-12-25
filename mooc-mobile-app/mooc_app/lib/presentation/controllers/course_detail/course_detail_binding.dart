import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_detail_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_controller.dart';

class CourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseDetailUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseDetailController(Get.find()));
  }
  
}