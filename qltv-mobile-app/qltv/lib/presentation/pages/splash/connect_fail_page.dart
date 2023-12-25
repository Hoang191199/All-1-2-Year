import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/pages/splash/splash_page.dart';

class ConnectFailPage extends StatelessWidget {
  const ConnectFailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.background,
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
            child: Container(
                padding: EdgeInsets.only(top: heightScreen / 3),
                child: Column(children: [
                  Container(
                    child: Row(children: [
                      Container(
                        width: widthScreen,
                        child: Center(
                          child: Text(
                            "no-internet-connection".tr,
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
                  SizedBox(
                    height: heightScreen / 2,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: CupertinoButton(
                        pressedOpacity: 0.65,
                        color: Colors.blue[900],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "try-again".tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () async {
                          Get.off(() => const SplashPage());
                        },
                      ))
                ]))));
  }
}
