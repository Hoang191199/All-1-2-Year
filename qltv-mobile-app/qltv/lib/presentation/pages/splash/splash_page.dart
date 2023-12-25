import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      width: controller.animation.value * 130,
                      height: controller.animation.value * 50,
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
