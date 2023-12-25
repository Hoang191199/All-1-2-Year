import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/notifications/noti_binding.dart';
import 'package:mooc_app/presentation/pages/profile/setting/option/see_token.dart';

import '../../../controllers/history/login_history_binding.dart';
import 'option/delete_account.dart';
import 'option/login_history.dart';

class SettingAccount extends StatelessWidget {
  const SettingAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Cài đặt và mật khẩu'),
        ),
        child: Padding(
            padding: EdgeInsets.only(
                top: const CupertinoNavigationBar().preferredSize.height +
                    statusBarHeight,
                left: 5),
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(children: [
                  CupertinoButton(
                    pressedOpacity: 0.65,
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Xem lịch sử đăng nhập",
                              style: TextStyle(color: Colors.black),
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
                      NotiBinding().dependencies;
                      LoginHistoryBinding().dependencies();
                      Get.to(() => LoginHistoryPage());
                    },
                  ),
                  // CupertinoButton(
                  //   pressedOpacity: 0.65,
                  //   color: Colors.white,
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.circular(0),
                  //   ),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 16),
                  //   alignment: Alignment.centerLeft,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(
                  //             "Xóa tài khoản",
                  //             style: TextStyle(color: Colors.black),
                  //           ),
                  //         ],
                  //       ),
                  //       const Icon(
                  //         CupertinoIcons.chevron_right,
                  //         color: Colors.grey,
                  //       ),
                  //     ],
                  //   ),
                  //   onPressed: () {
                  //     Get.to(() => const DeleteAccount());
                  //   },
                  // ),
                  // CupertinoButton(
                  //   pressedOpacity: 0.65,
                  //   color: Colors.white,
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.circular(0),
                  //   ),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 16),
                  //   alignment: Alignment.centerLeft,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(
                  //             "Xem token",
                  //             style: TextStyle(color: Colors.black),
                  //           ),
                  //         ],
                  //       ),
                  //       const Icon(
                  //         CupertinoIcons.chevron_right,
                  //         color: Colors.grey,
                  //       ),
                  //     ],
                  //   ),
                  //   onPressed: () {
                  //     Get.to(() => SeeToken());
                  //   },
                  // ),
                ]))));
  }
}
