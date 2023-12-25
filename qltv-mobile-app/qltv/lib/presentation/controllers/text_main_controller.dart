import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextMainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextEditingController searchpagefield;
  late TextEditingController pointcode;
  late TextEditingController searchcourse;
  final isInitialized = false.obs;
  @override
  void onInit() {
    mainsearchInitilization();
    super.onInit();
    isInitialized.value = true;
  }

  mainsearchInitilization() {
    searchpagefield = TextEditingController();
    pointcode = TextEditingController();
    searchcourse = TextEditingController();
  }
}
