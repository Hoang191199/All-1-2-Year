import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/shuttle_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/shuttle/shuttle_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';

class ShuttleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShuttleRepositoryImpl());
    Get.lazyPut(() => ShuttleUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => PickUpUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => SavePickUpUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => CancelPickUpUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => ListClassUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => ListChildUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => AddChildUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => AssignUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => HistoryUserCase(Get.find<ShuttleRepositoryImpl>()));
    Get.lazyPut(() => ShuttleController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
