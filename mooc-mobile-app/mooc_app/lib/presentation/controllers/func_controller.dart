import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FunctionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    landscapeMode();
    super.onInit();
  }

  @override
  void dispose() {
    setAllOrientation();
    super.dispose();
  }

  Future landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  Future setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

}