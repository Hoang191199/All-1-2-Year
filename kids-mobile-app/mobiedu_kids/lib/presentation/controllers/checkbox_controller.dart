import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_controller.dart';

class CheckBoxController extends GetxController {
  static CheckBoxController get to => Get.find<CheckBoxController>();

  final scheduleReviewController = Get.find<ScheduleReviewController>();
  final scheduleController = Get.find<ScheduleController>();
  final menuReviewController = Get.find<MenuReviewController>();
  final menuController = Get.find<MenuController>();
  @override
  void onInit() {
    super.onInit();
  }

  toggleScheduleAll(bool? tick) {
    scheduleReviewController.check.value
        .updateAll((key, value) => value = tick ?? false);
    update();
  }

  toggleMenuAll(bool? tick) {
    menuReviewController.check.value
        .updateAll((key, value) => value = tick ?? false);
    update();
  }

  toggleSchedule(String? id, bool? tick) {
    scheduleReviewController.check.value.update(id!, (value) => tick ?? false);
    update();
  }

  toggleMenu(String? id, bool? tick) {
    menuReviewController.check.value.update(id!, (value) => tick ?? false);
    update();
  }
}
