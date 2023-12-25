import 'package:get/get.dart';

import '../../../data/repositories/order_history_repository_impl.dart';
import '../../../domain/usecases/order_history_use_case.dart';
import 'order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistoryRepositoryImpl());
    Get.lazyPut(() => OrderHistoryUseCase(Get.find<OrderHistoryRepositoryImpl>()));
    Get.lazyPut(() => OrderHistoryController(Get.find()));
  }
}