import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NodeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode dobFocusNode;
  late FocusNode descriptionFocusNode;
  late FocusNode genderFocusNode;
  late FocusNode passwordFocusNode;
  @override
  void onInit() {
    nodeInitilization();
    super.onInit();
  }

  nodeInitilization() {
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }
}
