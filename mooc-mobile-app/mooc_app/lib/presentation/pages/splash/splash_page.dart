import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/notifications/noti_binding.dart';

import 'package:mooc_app/presentation/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    NotiBinding().dependencies();
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Headline'),
      // ),
      child: GetBuilder<SplashScreenViewModel>(
        init: SplashScreenViewModel(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: controller.animation.value * 200,
                    height: controller.animation.value * 200,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
