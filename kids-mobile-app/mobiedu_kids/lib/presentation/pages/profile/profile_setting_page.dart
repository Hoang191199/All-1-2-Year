import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/block/block_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/block/block_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/customize_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/language/language_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/widget/item_profile.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingPage({super.key});
  final logincontroller = Get.find<LogController>();
  final splashController = Get.find<SplashScreenController>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 12.0),
          leading: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.back,
                color: AppColors.primary,
              ),
            ),
          ),
          middle: Text(
            'Tài khoản',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 22.0,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          backgroundColor: Colors.white,
          border: const Border(),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 10 + bottomPadding),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  ProfileBinding().dependencies();
                  Get.to(() => CustomizePage());
                },
                child: const ItemProfile(image: "assets/images/customize.png", title: "Tài khoản")
              ),
              const Divider(thickness: 1.0),
              CupertinoButton(
                onPressed: () {
                  Get.to(() => LanguagePage());
                },
                child: const ItemProfile(image:"assets/images/language.png", title: "Ngôn ngữ")
              ),
              const Divider(thickness: 1.0),
              CupertinoButton(
                onPressed: () {
                  BlockBinding().dependencies();
                  Get.to(() => BlockPage());
                },
                child: const ItemProfile(image:"assets/images/block.png", title: "Danh sách chặn")
              ),
              const Divider(thickness: 1.0),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: widthScreen - 56,
                child: CupertinoButton(
                  onPressed: () async {
                    splashController.isShowNotification.value = false;
                    logincontroller.logout();
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.red,
                  child: Text(
                    'Đăng xuất',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  )
                )
              ),
            ]
          ),
        )
      )
    );
  }

}

