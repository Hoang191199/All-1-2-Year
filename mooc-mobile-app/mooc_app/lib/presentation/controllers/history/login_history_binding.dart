import 'package:get/get.dart';

import '../../../data/repositories/login_history_repository_impl.dart';
import '../../../domain/usecases/login_history_usecase.dart';
import 'login_history_controller.dart';

class LoginHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginHistoryRepositoryImpl());
    Get.lazyPut(() => LoginHistoryUseCase(Get.find<LoginHistoryRepositoryImpl>()));
    Get.lazyPut(() => LoginHistoryController(Get.find()));
  }

}