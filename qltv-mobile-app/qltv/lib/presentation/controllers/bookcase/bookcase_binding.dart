import 'package:get/get.dart';
import 'package:qltv/data/repositories/bookcase_repository_impl.dart';
import 'package:qltv/domain/usecases/bookcase_lastseen_use_case.dart';
import 'package:qltv/domain/usecases/bookcase_use_case.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';

class BookcaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookcaseRepositoryImpl());
    Get.lazyPut(() => BookcaseUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => BookcaseLastseenUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => BookcaseController(Get.find(), Get.find()));
  }
  
}