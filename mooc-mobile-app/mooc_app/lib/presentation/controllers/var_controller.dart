import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VariableController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RxBool isTappedDown;
  late var formKey;
  @override
  void onInit() {
    varInitilization();
    super.onInit();
  }

  varInitilization() {
    isTappedDown = false.obs;
    formKey = GlobalKey<FormState>();
  }
}
