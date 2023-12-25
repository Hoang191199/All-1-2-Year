import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/prescription_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';

class PrescriptionChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrescriptionRepositoryImpl());
    Get.lazyPut(() => PrescriptionChildUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => PrescriptionRegisterUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => PrescriptionChildController(Get.find(), Get.find()));
  }
}
