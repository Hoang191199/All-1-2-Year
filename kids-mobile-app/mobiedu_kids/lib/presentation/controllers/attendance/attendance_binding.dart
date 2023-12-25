import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/attendance_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/attendance_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceRepositoryImpl());
    Get.lazyPut(() => AttendanceUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => UploadImageUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => UpdateUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => UpdateCheckOutUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => ConFirmUserCase(Get.find<AttendanceRepositoryImpl>()));
    Get.lazyPut(() => AttendanceController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
