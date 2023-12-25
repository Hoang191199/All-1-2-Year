import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_controller.dart';
import 'package:mooc_app/presentation/controllers/login_controller.dart';

class LoginButton extends StatelessWidget {
  LoginButton({super.key});

  final loginController = Get.put(LoginController());
  final initPageTabController = Get.put(InitPageTabController());
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Obx(
      () => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 50.0 + bottomPadding),
          child: GestureDetector(
            onTap: (){
              // Get.to(() => const LoginPage());
              handlePressLogin(context);
            },
            onTapDown: (tapDownDetails) {
              loginController.tapButtonDown();
            },
            onTapUp: (tapUpDetails) {
              loginController.tapButtonUp();
            },
            child: Container(
              width: widthScreen,
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: loginController.isTappedDown.value ? Colors.grey.withOpacity(0.5) : Colors.grey[700]
              ),
              child: const Text(
                'ĐĂNG NHẬP',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          )
        )
      )
    );
  }

  void handlePressLogin(BuildContext context) async {
    await loginController.authenticate();
    if(initPageTabController.cupertinoTabController.index == 2) {
      if (context.mounted) {
        await handleRidirectToLearningCoursePage(context);
      } else {
        final learningCourseListController = Get.find<LearningCourseListController>();
        learningCourseListController.fetchData();
      }
    }
  }
}