import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/service_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/service_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';

class ServiceParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceRepositoryImpl());
    Get.lazyPut(() => ServiceParentUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => RegisterServiceUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => HistoryServiceParentUseCase(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => ServiceParentController(Get.find(), Get.find(), Get.find()));
  }
}
