import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

class RegisterCourseController extends GetxController {

  final authController = Get.find<AuthController>();

  late TextEditingController fullnameInputController;
  late TextEditingController emailInputController;
  late TextEditingController phoneInputController;
  final couponCodeInputController = TextEditingController();

  @override
  void onInit() {
    fullnameInputController = TextEditingController(text: authController.userLogin?.fullname);
    emailInputController = TextEditingController(text: authController.userLogin?.email);
    phoneInputController = TextEditingController(text: authController.userLogin?.phone);
    super.onInit();
  }
  
}