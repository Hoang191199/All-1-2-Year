import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/service_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/service_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceRepositoryImpl());
    Get.lazyPut(() => ServiceUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => UpdateServiceUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => HistoryUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => ServiceController(Get.find(), Get.find(), Get.find()));
  }
}
