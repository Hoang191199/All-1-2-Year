import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/network_controller.dart';
import 'package:mooc_app/presentation/controllers/notifications/noti_binding.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';
import 'package:mooc_app/presentation/pages/profile/mail_notifier/mail_notifier.dart';

import '../pages/splash/connect_fail.dart';
import 'notifications/list_noti_controller.dart';

class SplashScreenViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final noti = Get.find<ListNotiController>();
  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.back();
      NotiBinding().dependencies();
      noti.fetchData();
      Get.off(() => const MailNotice());
    });
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
    Future.delayed(const Duration(seconds: 2),  () async{
      final connect = await Get.put(GetXNetworkManager());
      await recurve(connect);
    });
  }

  recurve(connect) async{
    if(connect.isInitialized.value == true) {
      if (connect.connectionType != 0){
        Get.off(()=> InitPage(index: 0,));
        setupInteractedMessage();
      }
      else{
        Get.off(()=> ConnectFailPage());
      }
    }
    else{
      await Future.delayed(const Duration(milliseconds: 100),(){});
      await recurve(connect);
    }
  }
}
