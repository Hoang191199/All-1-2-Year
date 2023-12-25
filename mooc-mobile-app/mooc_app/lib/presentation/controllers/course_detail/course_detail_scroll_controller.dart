import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CourseDetailScrollController extends GetxController {
  final scrollController = ScrollController();
  RxBool showBottom = false.obs;
  
  @override
  void onInit() {
    scrollInitilization();
    super.onInit();
  }

  scrollInitilization() {
    scrollController.addListener(() { 
      if (scrollController.position.pixels >= 350.0) {
        showBottom.value = true;
      } else {
        showBottom.value = false;
      }
    });
  }
}
