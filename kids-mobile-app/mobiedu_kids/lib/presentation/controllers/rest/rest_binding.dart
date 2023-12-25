import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/rest_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/rest_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_controller.dart';

class RestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestRepositoryImpl());
    Get.lazyPut(() => RestUseCase(Get.find<RestRepositoryImpl>()));
    Get.lazyPut(() => RestRegisterUseCase(Get.find<RestRepositoryImpl>()));
    Get.lazyPut(() => RestController(Get.find(), Get.find()));
  }
}
