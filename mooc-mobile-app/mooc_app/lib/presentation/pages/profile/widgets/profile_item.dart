import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/presentation/controllers/history/login_history_binding.dart';
import 'package:mooc_app/presentation/controllers/history/order_history_binding.dart';
import 'package:mooc_app/presentation/controllers/notifications/noti_binding.dart';
import 'package:mooc_app/presentation/controllers/rate_controller.dart';
import 'package:mooc_app/presentation/controllers/s3/s3_binding.dart';
import 'package:mooc_app/presentation/pages/learning/history/history.dart';
import 'package:mooc_app/presentation/pages/profile/setting/setting.dart';
import 'package:mooc_app/presentation/pages/profile/update_profile/update.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../../controllers/profile/profile_binding.dart';
import '../mail_notifier/mail_notifier.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.titleItem,
    required this.typeItem,
  });

  final String titleItem;
  final String typeItem;

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
      if (typeItem == 'support') {
        dialogSupport(context);
      } else if (typeItem == 'rate') {
        // Get.to(() => RatePage(builder: (rate) => RateDialogPage(rateMyApp: rate)));
        if (Platform.isIOS) {
          rate.showStarRateDialog(
            context,
            title: 'Đánh giá ứng dụng',
            message: 'Cảm thấy thích chúng tôi ? Hãy để lại đánh giá nhé',
            starRatingOptions: const StarRatingOptions(initialRating: 0),
            actionsBuilder: actionsBuilder,
          );
          // rate.showStarRateDialog(
          //   context,
          //   title: 'Đánh giá ứng dụng',
          //   message: 'Cảm thấy thích chúng tôi ? Hãy để lại đánh giá nhé',
          //   actionsBuilder: (context, stars) {
          //     return [
          //       TextButton(
          //         child: Text('OK'),
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
        } else {
          rate.showRateDialog(context,
              title: "Đánh giá ứng dụng",
              message: "Cảm thấy thích chúng tôi ? Hãy để lại đánh giá nhé",
              rateButton: "Đánh giá",
              noButton: "Không, cảm ơn",
              laterButton: "Để sau",
              ignoreNativeDialog: Platform.isAndroid);
        }
      } else if (typeItem == "link") {
        showAlertDialog(context);
      } else if (typeItem == 'notice') {
        LoginHistoryBinding().dependencies();
        NotiBinding().dependencies();
        Get.to(() => const MailNotice());
        // } else if (typeItem == 'learning_path') {
        //   Get.to(() => const Roadmap());
      } else if (typeItem == 'setting') {
        Get.to(() => const SettingAccount());
      } else if (typeItem == 'order_history') {
        OrderHistoryBinding().dependencies();
        Get.to(() => const HistoryPage());
      } else if (typeItem == 'profile') {
        ProfileBinding().dependencies();
        S3Binding().dependencies();
        Get.to(() => const UpdateProfile());
      }
    }

    return RateMyAppBuilder(
      rateMyApp: rate.rateMyApp,
      onInitialized: (context, rateMyApp) {},
      builder: (context) {
        return rate.rateMyApp == null
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () => handleTapItem(rate.rateMyApp, typeItem, context),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 6.0, bottom: 6.0, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titleItem,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black)),
                      // const Icon(CupertinoIcons.forward, size: 22.0, color: Colors.black54)
                    ],
                  ),
                ),
              );
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Link giới thiệu"),
    content: SelectableText("Link: https://moocs.codeinet.com"),
    actions: [
      TextButton(
        child: Text("Copy"),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: "https://moocs.codeinet.com"));
          showSnackbar("success", "Thành công", "Đã lưu vào clipboard");
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> dialogSupport(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                padding: const EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 42.0),
                        child: Text(
                          'Hỗ trợ',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: const Icon(CupertinoIcons.clear,
                              size: 22.0, color: Colors.black54),
                        ))
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(CupertinoIcons.phone, color: Colors.black54),
                      SizedBox(width: 6.0),
                      Text('Số điện thoại',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text('0999999999',
                      style: TextStyle(color: AppColors.primaryBlue))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(CupertinoIcons.mail, color: Colors.black54),
                      SizedBox(width: 6.0),
                      Text('Email',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text('cskh@mooc.vn',
                      style: TextStyle(color: AppColors.primaryBlue))
                ],
              ),
            ),
            const SizedBox(height: 20.0)
          ],
        ),
      );
    },
  );
}
