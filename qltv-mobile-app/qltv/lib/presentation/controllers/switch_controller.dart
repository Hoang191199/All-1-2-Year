import 'package:get/get.dart';
import '../../app/services/local_storage.dart';

class SwitchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final store = Get.find<LocalStorageService>();
  final sw = false.obs;
  @override
  void onInit() {
    switchInitilization();
    super.onInit();
  }

  switchInitilization() {
    sw.value = store.checkNotification;
  }
}
