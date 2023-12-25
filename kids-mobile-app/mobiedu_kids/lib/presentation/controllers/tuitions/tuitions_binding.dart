import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/tuitions_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_detail_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_item_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/tuitions/tuitions_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_controller.dart';

class TuitionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TuitionsRepositoryImpl());
    Get.lazyPut(() => TuitionsUserCase(Get.find<TuitionsRepositoryImpl>()));
    Get.lazyPut(() => TuitionsDetailUserCase(Get.find<TuitionsRepositoryImpl>()));
    Get.lazyPut(() => TuitionsItemUserCase(Get.find<TuitionsRepositoryImpl>()));
    Get.lazyPut(() => TuitionsController(Get.find(), Get.find(), Get.find()));
  }
}
