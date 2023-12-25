import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/tuitions_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_controller.dart';

class TuitionsParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TuitionsRepositoryImpl());
    Get.lazyPut(() => TuitionsParentUseCase(Get.find<TuitionsRepositoryImpl>()));
    Get.lazyPut(() => TuitionsParentDetailUseCase(Get.find<TuitionsRepositoryImpl>()));
    Get.lazyPut(() => TuitionsParentController(Get.find(), Get.find()));
  }
}
