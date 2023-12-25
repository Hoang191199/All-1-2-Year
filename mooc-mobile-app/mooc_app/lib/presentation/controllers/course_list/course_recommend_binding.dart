import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/course_recommend_use_case.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_controller.dart';

class CourseRecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseRecommendUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CourseRecommendController(Get.find()));
  }
  
}