import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/role_user_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/role_user_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoleUserRepositoryImpl());
    Get.lazyPut(() => RoleUserUseCase(Get.find<RoleUserRepositoryImpl>()));
    Get.lazyPut(() => SplashScreenController(Get.find()));
  }
}
