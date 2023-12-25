import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  
  Widget build(BuildContext context) {
    InformationBinding().dependencies();
    MenuBinding().dependencies();
    MenuReviewBinding().dependencies();
    SplashBinding().dependencies();
    NotificationBinding().dependencies();
    final splashController = Get.find<SplashScreenController>();
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: GetBuilder<SplashScreenController>(
        init: splashController,
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/background_splash.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 2),
                      child: controller.animation.value >= 1
                      ? Column(
                          children: [
                            Image.asset(
                              'assets/images/child.png',
                              width: controller.animation.value * 276,
                              height: controller.animation.value * 276,
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              'Phần mềm quản lý và kết nối nhà trường mobiEdu',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      :Image.asset(
                        'assets/images/logo.png',
                        width: controller.animation.value * 130,
                        height: controller.animation.value * 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
