import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/attendance_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_controller.dart';

class HygieneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceRepositoryImpl());
    Get.lazyPut(() => HygieneUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => UpdateHygieneUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => HygieneController(Get.find(), Get.find()));
  }
}
