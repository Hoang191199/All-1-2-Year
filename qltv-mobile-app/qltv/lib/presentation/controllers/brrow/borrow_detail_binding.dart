import 'package:get/get.dart';
import 'package:qltv/data/repositories/borrow_repository_impl.dart';
import 'package:qltv/domain/usecases/borrow_detail_use_case.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_detail_controller.dart';

class BorrowDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BorrowRepositoryImpl());
    Get.lazyPut(() => BorrowDetailUseCase(Get.find<BorrowRepositoryImpl>()));
    Get.lazyPut(() => BorrowDetailController(Get.find()));
  }
}
