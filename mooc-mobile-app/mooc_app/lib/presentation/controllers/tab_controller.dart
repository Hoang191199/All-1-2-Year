import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController with GetSingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(
        text: 'Khóa học trọn đời'
    ),
    Tab(
        text: 'Thẻ học'
    ),
    Tab(
        text: 'Học trải nghiệm'
    ),
  ];
  final List<String> myTitle = [
        'Khóa học trọn đời',
        'Thẻ học',
        'Học trải nghiệm',
  ];
  final index = 0.obs;
  late TabController controller;

  @override
  void onInit() {
    tabInitilization();
    super.onInit();
  }

  tabInitilization() {
    controller = TabController(length: myTabs.length,vsync: this);
    controller.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
      index.value = controller.index;
  }
}
