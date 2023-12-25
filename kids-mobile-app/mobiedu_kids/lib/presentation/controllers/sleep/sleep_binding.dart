import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/attendance_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_controller.dart';

class SleepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceRepositoryImpl());
    Get.lazyPut(() => SleepUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => UpdateSleepUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => SleepController(Get.find(), Get.find()));
  }
}
