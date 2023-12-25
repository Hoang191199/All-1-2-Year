import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/node_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/text_profile_controller.dart';

class ChangeName extends StatelessWidget {
  ChangeName({super.key});

  final loginController = Get.find<LoginController>();
  final profile = Get.find<ProfileController>();
  final tex = Get.put(TextUpdateProfileController());
  final node = Get.put(NodeController());

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          await profile.fetchProfile();
          await tex.updateprofileInitilization();
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
                                      await tex.updateprofileInitilization();
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
                                    "setting-profile-name".tr,
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
                                  "input-new-name".tr,
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
                                          GetBuilder<
                                                  TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(),
                                              // initState: (state) async {
                                              //   await TextUpdateProfileController
                                              //       .to
                                              //       .updateprofileInitilization();
                                              // }, // intialize with the Controller
                                              builder: (value) => Container(
                                                  width: widthScreen - 60 - 36,
                                                  child: EditableText(
                                                      controller:
                                                          TextUpdateProfileController
                                                              .to.nameText,
                                                      focusNode:
                                                          node.nameFocusNode,
                                                      style: GoogleFonts.kantumruy(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      17.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      cursorColor: Colors.black,
                                                      backgroundCursorColor:
                                                          Colors.grey))),
                                          // Container(
                                          //     width: widthScreen - 60 - 36,
                                          //     child: EditableText(
                                          //         controller: tex.nameText,
                                          //         focusNode: node.nameFocusNode,
                                          //         style: GoogleFonts.kantumruy(
                                          //             textStyle: const TextStyle(
                                          //                 fontSize: 17.0,
                                          //                 color: Colors.black,
                                          //                 fontWeight:
                                          //                     FontWeight.bold)),
                                          //         cursorColor: Colors.black,
                                          //         backgroundCursorColor:
                                          //             Colors.grey))
                                        ],
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ])),
                          SizedBox(
                            height: heightScreen / 2,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28),
                              child: CupertinoButton(
                                pressedOpacity: 0.65,
                                color: Colors.blue[900],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "save".tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  profile.updateProfile(
                                      tex.nameText.text,
                                      tex.emailText.text,
                                      tex.phoneText.text,
                                      tex.dobText.text,
                                      int.parse(tex.genderText.text).toInt(),
                                      "",
                                      tex.avatarText.text);
                                },
                              ))
                        ],
                      ),
                    )))));
  }
}
