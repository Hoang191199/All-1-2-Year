import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/cart_use_case.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CartUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CartController(Get.find()));
  }
}