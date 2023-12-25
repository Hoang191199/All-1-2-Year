import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/domain/usecases/coupon_code_use_case.dart';
import 'package:mooc_app/presentation/controllers/coupon_code/coupon_code_controller.dart';

class CouponCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseRepositoryImpl());
    Get.lazyPut(() => CouponCodeUseCase(Get.find<CourseRepositoryImpl>()));
    Get.lazyPut(() => CouponCodeController(Get.find()));
  }
  
}