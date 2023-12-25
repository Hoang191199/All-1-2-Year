import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/log_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/log_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';

class LogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogRepositoryImpl());
    Get.lazyPut(() => LoginUseCase(Get.find<LogRepositoryImpl>()));
    Get.lazyPut(() => LogoutUseCase(Get.find<LogRepositoryImpl>()));
    Get.lazyPut(() => LogController(Get.find(), Get.find()));
  }
}
