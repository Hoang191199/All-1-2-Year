import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/carousel_controller.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/network_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart';
import 'package:qltv/presentation/pages/init/init_page.dart';
import 'package:qltv/presentation/pages/login/login_page.dart';
import 'package:qltv/presentation/pages/splash/connect_fail_page.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final loginController = Get.find<LoginController>();

  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    animationController.forward();
    Future.delayed(const Duration(seconds: 2), () async {
      final connect = Get.put(GetXNetworkManager());
      await recurve(connect);
    });
  }

  recurve(connect) async {
    if (connect.isInitialized.value == true) {
      if (connect.connectionType != 0) {
        if (loginController.userLogin != null) {
          Get.delete<ProfileController>();
          Get.delete<HomeController>();
          Get.delete<BookcaseController>();
          Get.delete<BorrowController>();
          Get.delete<SearchController>();
          Get.delete<CarouselSlideController>();
          Get.off(() => InitPage());
        } else {
          Get.off(() => LoginPage());
        }
      } else {
        Get.off(() => const ConnectFailPage());
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100), () {});
      await recurve(connect);
    }
  }
}
