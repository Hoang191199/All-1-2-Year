import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/menu_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/menu_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuRepositoryImpl());
    Get.lazyPut(() => GetMenuUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => GetMenuChildUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => HistoryMenuUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => DetailMenuUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => HistoryMenuChildUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => DetailMenuChildUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => SchoolListMenuUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => SchoolDetailMenuUseCase(Get.find<MenuRepositoryImpl>()));
    Get.lazyPut(() => MenuController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
