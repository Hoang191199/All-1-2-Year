import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
// import 'package:qltv/presentation/controllers/node_controller.dart';
// import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
// import 'package:qltv/presentation/controllers/text_profile_controller.dart';

class ChangeLanguage extends StatelessWidget {
  ChangeLanguage({super.key});

  final loginController = Get.find<LoginController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    // final tex = Get.put(TextUpdateProfileController());
    // final node = Get.put(NodeController());
    // final profile = Get.find<ProfileController>();
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
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
                                "language".tr,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "vi".tr,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onPressed: () {
                                updateLocale(const Locale('vi', 'VN'), context);
                              },
                            ),
                          ])),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "en".tr,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onPressed: () {
                                updateLocale(const Locale('en', 'US'), context);
                              },
                            ),
                          ])),
                    ],
                  ),
                ))));
  }

  updateLocale(Locale locale, BuildContext context) {
    Get.updateLocale(locale);
    store.setLocale = [locale.languageCode, locale.countryCode ?? ""];
  }
}
