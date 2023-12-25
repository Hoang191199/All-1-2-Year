import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';

class CheckBoxEventController extends GetxController {
  static CheckBoxEventController get to => Get.find<CheckBoxEventController>();
  final eventController = Get.find<EventController>();
  @override
  void onInit() {
    super.onInit();
  }

  toggleEventChildAll(bool? tick) {
    eventController.checkChild.value.updateAll(
      (key, value) => value = tick ?? false,
    );
    update();
  }

  toggleEventChild(String id, bool? tick) {
    eventController.checkChild.value.update(id, (value) => tick ?? false);
    update();
  }

  toggleEventParentAll(bool? tick) {
    eventController.checkParent.value.updateAll(
      (key, value) => value = tick ?? false,
    );
    update();
  }

  toggleEventParent(String id, bool? tick) {
    eventController.checkParent.value.update(id, (value) => tick ?? false);
    update();
  }

  toggleEventParentChild(bool? tick) {
    eventController.checkParentInvi.value = tick ?? false;
    update();
  }

  toggleEventChildChild(bool? tick) {
    eventController.checkChildInvi.value = tick ?? false;
    update();
  }
}
