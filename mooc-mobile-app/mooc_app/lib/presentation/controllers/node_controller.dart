import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';
import 'package:rate_my_app/rate_my_app.dart';

class NodeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode dobFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode genderFocusNode;
  @override
  void onInit() {
    nodeInitilization();
    super.onInit();
  }

  nodeInitilization() {
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    genderFocusNode = FocusNode();
  }
}
