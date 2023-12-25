import 'package:get/get.dart';
import 'package:qltv/data/repositories/login_repository_impl.dart';
import 'package:qltv/domain/usecases/login_use_case.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepositoryImpl());
    Get.lazyPut(() => LoginUseCase(Get.find<LoginRepositoryImpl>()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
