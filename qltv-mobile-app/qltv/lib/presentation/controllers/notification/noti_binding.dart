import 'package:get/get.dart';

import '../../../data/repositories/noti_repository_impl.dart';
import '../../../domain/usecases/noti_use_case.dart';
import 'noti_controller.dart';

class NotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotiRepositoryImpl());
    Get.lazyPut(() => NotiUseCase(Get.find<NotiRepositoryImpl>()));
    Get.lazyPut(() => NotiController(Get.find()));
  }

}