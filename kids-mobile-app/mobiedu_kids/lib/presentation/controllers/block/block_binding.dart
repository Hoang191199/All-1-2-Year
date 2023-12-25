import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/block_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/block_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/block/block_controller.dart';

class BlockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlockRepositoryImpl());
    Get.lazyPut(() => ListBlockUseCase(Get.find<BlockRepositoryImpl>()));
    Get.lazyPut(() => UnblockUseCase(Get.find<BlockRepositoryImpl>()));
    Get.lazyPut(() => BlockController(Get.find(), Get.find()));
  }
}
