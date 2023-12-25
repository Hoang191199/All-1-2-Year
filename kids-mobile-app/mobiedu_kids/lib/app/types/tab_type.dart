import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';

final splashController = Get.find<SplashScreenController>();
final notificationController = Get.find<NotificationController>();

enum TabType { manager, news, messenger, notification, profile, information }

extension TabItem on TabType {
  Widget get icon {
    switch (this) {
      case TabType.manager:
        return navItem(
          "Quản lý", 
          const FaIcon(FontAwesomeIcons.gear, size: 24.0),
          false
        );
      case TabType.news:
        return navItem(
          "Bảng tin", 
          const FaIcon(FontAwesomeIcons.newspaper, size: 24.0),
          false
        );
      case TabType.messenger:
        return splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false ?
          navItem(
            "Tin nhắn",
            const FaIcon(FontAwesomeIcons.comment, size: 24.0),
            false
          )
          : const SizedBox();
      case TabType.notification:
        return SizedBox(
          child: Stack(children: [
            navItem(
              "Thông báo", 
              const FaIcon(FontAwesomeIcons.bell, size: 24.0),
              false
            ),
            Obx(() {
              final countNotification = int.parse(notificationController.responseData.value?.data?.count_notification ?? '0');
              return ((splashController.isShowNotification.value == false) && (countNotification > 0))
                ? Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      child: Text(countNotification > 99 ? '99+' : countNotification.toString(),
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 10.0
                        ),
                      ),
                    )
                  )
                : const SizedBox();
            })
          ]),
        );
      case TabType.profile:
        return navItem(
          "Tài khoản", 
          const FaIcon(FontAwesomeIcons.circleUser, size: 24.0),
          false
        );
      case TabType.information:
        return navItem(
          "Bảng tin", 
          const FaIcon(FontAwesomeIcons.newspaper, size: 24.0),
          false
        );
    }
  }

  Widget get activeIcon {
    switch (this) {
      case TabType.manager:
        return navItem(
          "Quản lý", 
          const FaIcon(FontAwesomeIcons.gear, size: 24.0),
          true
        );
      case TabType.news:
        return navItem(
          "Bảng tin", 
          const FaIcon(FontAwesomeIcons.newspaper, size: 24.0),
          true
        );
      case TabType.messenger:
        return splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false ?
        navItem(
          "Tin nhắn", 
          const FaIcon(FontAwesomeIcons.comment, size: 24.0),
          true
        )
        : const SizedBox(); 
      case TabType.notification:
        return navItem(
          "Thông báo", 
          const FaIcon(FontAwesomeIcons.bell, size: 24.0),
          true
        );
      case TabType.profile:
        return navItem(
          "Tài khoản", 
          const FaIcon(FontAwesomeIcons.circleUser, size: 24.0),
          true
        );
      case TabType.information:
        return navItem(
          "Bảng tin", 
          const FaIcon(FontAwesomeIcons.newspaper, size: 24.0),
          true
        );
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case TabType.manager:
        return "Quản lý";
      case TabType.news:
        return "Bảng tin";
      case TabType.messenger:
        return "Tin nhắn";
      case TabType.notification:
        return "Thông báo";
      case TabType.profile:
        return "Tài khoản";
      case TabType.information:
        return "Bảng tin";
    }
  }

  Widget navItem(String text, Widget icon, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active ? AppColors.lightPink2 : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4.0),
          Text(
            text,
            style: styleNavLable(active),
          )
        ]
      )
    );
  }

  TextStyle styleNavLable(bool active){
    return GoogleFonts.raleway(
      textStyle: TextStyle(
        color: active ? AppColors.primary : AppColors.pink,
        fontWeight: FontWeight.w500,
        // fontSize: 11.0,
        // height: 1.5,
      ),
    );
  }
}
