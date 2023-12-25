import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/home_repository_impl.dart';
import 'package:mooc_app/domain/usecases/home_use_case.dart';
import 'package:mooc_app/presentation/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeUseCase(Get.find<HomeRepositoryImpl>()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
  
}