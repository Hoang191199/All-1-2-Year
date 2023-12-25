import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextRoadmapController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextEditingController search;
  late TextEditingController title;
  final isInitialized = false.obs;
  @override
  void onInit() {
    roadmapInitilization();
    super.onInit();
    isInitialized.value = true;
  }

  roadmapInitilization() {
    search = TextEditingController();
    title = TextEditingController();
  }
}