import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qltv/presentation/controllers/lending/lending_binding.dart';
import 'package:qltv/presentation/controllers/notification/noti_binding.dart';
import 'package:qltv/presentation/controllers/profile/profile_binding.dart';
import 'package:qltv/presentation/pages/account/option/history.dart';
import 'package:qltv/presentation/pages/account/option/notification.dart';
import 'package:qltv/presentation/pages/account/option/setting.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/rate_controller.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.titleItem,
    required this.typeItem,
    required this.icon,
    required this.order,
  });

  final String titleItem;
  final String typeItem;
  final IconData icon;
  final int order;

  @override
  Widget build(BuildContext context) {
    final rate = Get.put(RateController());
    Widget buildOkButton(BuildContext context, double stars) =>
        RateMyAppRateButton(
          // child: Text('OK'),
          // onPressed: () async {
          //   // await rate.rateMyApp
          //   //     .callEvent(RateMyAppEventType.rateButtonPressed);
          //   rate.rateMyApp.launchStore();
          //   Navigator.of(context).pop();
          // },
          rate.rateMyApp,
          text: 'rate-confirm'.tr,
        );
    Widget buildCancelButton() => RateMyAppNoButton(
          rate.rateMyApp,
          text: 'rate-reject'.tr,
        );
    List<Widget> actionsBuilder(BuildContext context, double? stars) =>
        stars == null || stars == 0
            ? [buildCancelButton()]
            : [buildOkButton(context, stars), buildCancelButton()];
    handleTapItem(rate, typeItem, context) {
      if (typeItem == 'rate') {
        if (Platform.isIOS) {
          // rate.showStarRateDialog(
          //   context,
          //   title: "rate".tr,
          //   message: "rate-message".tr,
          //   actionsBuilder: (context, stars) {
          //     return [
          //       TextButton(
          //         child: const Text('OK'),
          //         onPressed: () async {
          //           await rate.callEvent(RateMyAppEventType.rateButtonPressed);
          //           Navigator.pop<RateMyAppDialogButton>(
          //               context, RateMyAppDialogButton.rate);
          //         },
          //       ),
          //     ];
          //   },
          //   dialogStyle: const DialogStyle(
          //     titleAlign: TextAlign.center,
          //     messageAlign: TextAlign.center,
          //     messagePadding: EdgeInsets.only(bottom: 20),
          //   ),
          // );
          rate.showStarRateDialog(
            context,
            title: "rate".tr,
            message: "rate-message".tr,
            starRatingOptions: const StarRatingOptions(initialRating: 0),
            actionsBuilder: actionsBuilder,
          );
        } else {
          // rate.showStarRateDialog(
          //   context,
          //   title: "rate".tr,
          //   message: "rate-message".tr,
          //   starRatingOptions: const StarRatingOptions(initialRating: 0),
          //   actionsBuilder: actionsBuilder,
          // );
          rate.showRateDialog(context,
              title: "rate".tr,
              message: "rate-message".tr,
              rateButton: "rate-confirm".tr,
              noButton: "rate-reject".tr,
              laterButton: "rate-later".tr,
              ignoreNativeDialog: Platform.isAndroid);
        }
      } else if (typeItem == 'history') {
        LendingBinding().dependencies();
        Get.to(() => HistoryPage());
      } else if (typeItem == 'notification') {
        NotiBinding().dependencies();
        Get.to(() => NotificationPage());
      } else if (typeItem == 'setting') {
        ProfileBinding().dependencies();
        Get.to(() => SettingPage());
      }
    }

    return RateMyAppBuilder(
        rateMyApp: rate.rateMyApp,
        onInitialized: (context, rateMyApp) {},
        builder: (context) {
          return CupertinoButton(
            pressedOpacity: 0.65,
            color: Colors.white,
            borderRadius: order == 1
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : (order == 2 || order == 3)
                    ? BorderRadius.zero
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                          height: 28,
                          width: 28,
                          child: Icon(
                            icon,
                            color: Colors.blue,
                          )),
                    ),
                    Text(
                      titleItem,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
            onPressed: () {
              handleTapItem(rate.rateMyApp, typeItem, context);
            },
          );
        });
  }
}
