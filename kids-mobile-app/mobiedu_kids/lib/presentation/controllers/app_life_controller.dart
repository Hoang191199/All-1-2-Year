import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLifeController extends GetxController with WidgetsBindingObserver {
  var shouldBlur = RxBool(false);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    shouldBlur.value = state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused;
  }
}
