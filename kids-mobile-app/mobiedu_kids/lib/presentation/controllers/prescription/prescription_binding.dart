import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/prescription_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_add_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/show_child_active_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/take_medicines_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';

class PrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrescriptionRepositoryImpl());
    Get.lazyPut(() => PrescriptionUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => TakeMedicinesUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => ShowChildActiveUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => PrescriptionAddUserCase(Get.find<PrescriptionRepositoryImpl>()));
    Get.lazyPut(() => PrescriptionController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
