import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/checkout_courses_use_case.dart';
import 'package:mooc_app/domain/usecases/validate_checkout_use_case.dart';
import 'package:mooc_app/presentation/controllers/checkout_courses/checkout_courses_controller.dart';

class CheckoutCoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CheckoutCoursesUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => ValidateCheckoutUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CheckoutCoursesController(Get.find(), Get.find()));
  }
  
}