import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';

class CheckBoxRemarkController extends GetxController {
  static CheckBoxRemarkController get to =>
      Get.find<CheckBoxRemarkController>();
  final remarkController = Get.find<RemarkController>();
  @override
  void onInit() {
    super.onInit();
  }

  toggleRemarkAll(bool? tick) {
    remarkController.checkDaily.value.updateAll(
      (key, value) => value = tick ?? false,
    );
    update();
  }

  toggleRemark(String id, bool? tick) {
    remarkController.checkDaily.value.update(id, (value) => tick ?? false);
    update();
  }
}
