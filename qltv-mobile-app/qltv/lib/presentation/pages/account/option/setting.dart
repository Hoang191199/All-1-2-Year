import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_binding.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/pages/account/option/setting_option/change_language.dart';
import 'package:qltv/presentation/pages/account/option/setting_option/change_mail.dart';
import 'package:qltv/presentation/pages/account/option/setting_option/change_name.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final loginController = Get.find<LoginController>();
  final profile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          await profile.fetchProfile();
          return false;
        },
        child: Scaffold(
            body: Container(
                padding: EdgeInsets.only(top: statusBarHeight, bottom: 0),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            child: Row(children: [
                              Container(
                                width: widthScreen / 6,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      Get.back();
                                      await profile.fetchProfile();
                                    },
                                    icon: const Icon(
                                      Icons.chevron_left_rounded,
                                      size: 40,
                                      weight: 5,
                                      color: Colors.grey,
                                    )),
                              ),
                              Container(
                                width: widthScreen * 4 / 6,
                                child: Center(
                                  child: Text(
                                    "setting".tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.kantumruy(
                                        textStyle: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, left: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "setting-profile".tr,
                                  style: GoogleFonts.kantumruy(
                                      textStyle: const TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                left: 28,
                                right: 28,
                                bottom: 20.0,
                              ),
                              width: widthScreen,
                              child: Column(children: [
                                CupertinoButton(
                                  pressedOpacity: 0.65,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "setting-profile-email".tr,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await profile.fetchProfile();
                                    ProfileBinding().dependencies();
                                    Get.to(() => ChangeMail());
                                  },
                                ),
                                CupertinoButton(
                                  pressedOpacity: 0.65,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "setting-profile-name".tr,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await profile.fetchProfile();
                                    ProfileBinding().dependencies();
                                    Get.to(() => ChangeName());
                                  },
                                ),
                              ])),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, left: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "setting-notification".tr,
                                  style: GoogleFonts.kantumruy(
                                      textStyle: const TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                left: 28,
                                right: 28,
                                bottom: 20.0,
                              ),
                              width: widthScreen,
                              child: Column(children: [
                                CupertinoButton(
                                  pressedOpacity: 0.65,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "setting-notification-library".tr,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      CupertinoSwitch(
                                        value: true,
                                        onChanged: (bool value) {},
                                        activeColor: const Color(0xff8E2912),
                                      )
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                                CupertinoButton(
                                  pressedOpacity: 0.65,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "setting-notification-system".tr,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      CupertinoSwitch(
                                        value: false,
                                        onChanged: (bool value) {},
                                        activeColor: const Color(0xff8E2912),
                                      )
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ])),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, left: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "language".tr,
                                  style: GoogleFonts.kantumruy(
                                      textStyle: const TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                left: 28,
                                right: 28,
                                bottom: 20.0,
                              ),
                              width: widthScreen,
                              child: Column(children: [
                                CupertinoButton(
                                  pressedOpacity: 0.65,
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "active-language".tr,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Get.to(() => ChangeLanguage());
                                  },
                                ),
                              ])),
                        ],
                      ),
                    )))));
  }
}
