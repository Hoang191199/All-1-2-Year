import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InitPageTabController extends GetxController {
  final cupertinoTabController = CupertinoTabController();

  changeIndexTab(int? index) {
    cupertinoTabController.index = index ?? 0;
  }
}