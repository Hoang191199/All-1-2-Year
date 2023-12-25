import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/schedule_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/schedule_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_controller.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleRepositoryImpl());
    Get.lazyPut(() => GetScheduleUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => GetScheduleChildUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(() => ViewScheduleUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => DetailScheduleUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => ViewScheduleChildUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => DetailScheduleChildUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => SchoolListScheduleUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(
        () => SchoolDetailScheduleUseCase(Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(() => ScheduleController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
