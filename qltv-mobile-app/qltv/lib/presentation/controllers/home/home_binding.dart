import 'package:get/get.dart';
import 'package:qltv/data/repositories/home_repository_impl.dart';
import 'package:qltv/domain/usecases/book_detail_user_case.dart';
import 'package:qltv/domain/usecases/home_use_case.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRepositoryImpl());
    Get.lazyPut(() => HomeUseCase(Get.find<HomeRepositoryImpl>()));
    Get.lazyPut(() => BookDetailUseCase(Get.find<HomeRepositoryImpl>()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find()));
  }
  
}