import 'package:get/get.dart';

import '../../../data/repositories/lending_repository_impl.dart';
import '../../../domain/usecases/lending_use_case.dart';
import 'lending_controller.dart';

class LendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LendingRepositoryImpl());
    Get.lazyPut(() => LendingUseCase(Get.find<LendingRepositoryImpl>()));
    Get.lazyPut(() => LendingController(Get.find()));
  }

}