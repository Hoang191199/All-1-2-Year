import 'package:get/get.dart';
import 'package:qltv/data/repositories/borrow_repository_impl.dart';
import 'package:qltv/domain/usecases/borrow_add_use_case.dart';
import 'package:qltv/domain/usecases/borrow_delete_user_case.dart';
import 'package:qltv/domain/usecases/borrow_update_use_case.dart';
import 'package:qltv/domain/usecases/borrow_use_case.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';

class BorrowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BorrowRepositoryImpl());
    Get.lazyPut(() => BorrowUseCase(Get.find<BorrowRepositoryImpl>()));
    Get.lazyPut(() => BorrowAddUseCase(Get.find<BorrowRepositoryImpl>()));
    Get.lazyPut(() => BorrowDeleteUseCase(Get.find<BorrowRepositoryImpl>()));
    Get.lazyPut(() => BorrowUpdateUseCase(Get.find<BorrowRepositoryImpl>()));
    Get.lazyPut(() => BorrowController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
