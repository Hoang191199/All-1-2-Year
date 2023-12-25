import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/rate_controller.dart';
import 'package:rate_my_app/rate_my_app.dart';

class PresentPage extends StatelessWidget {
  PresentPage({super.key});

  final store = Get.find<LocalStorageService>();
  final rate = Get.put(RateController());

  @override
  Widget build(BuildContext context) {
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
            'Giới thiệu',
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), //border corner radius
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightPink2.withOpacity(0.3), //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 3, // blur radius
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: const ClipRRect(
                  child: Image(
                    height: 75.0,
                    width: 200.0,
                    image: AssetImage("assets/images/kids_big.png"),
                    fit: BoxFit.contain
                  ),
                ),
              ),
              Text(
                "Version 1",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                "MobiFone Digital Service Center",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Liên hệ",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CupertinoButton(
                        onPressed: () {},
                        child: itemContact("assets/images/web.png", "https://kids.mobiedu.vn")
                      ),
                      const Divider(thickness: 1.0,),
                      CupertinoButton(
                        onPressed: () {},
                        child: itemContact("assets/images/mail.png", "contact@mobiedu.vn")
                      ),
                      const Divider(thickness: 1.0,),
                      CupertinoButton(
                        onPressed: () {},
                        child: itemContact("assets/images/tel.png", "0777202020.vn")
                      ),
                      const Divider(thickness: 1.0),
                      const SizedBox(height: 34.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Đánh giá ứng dụng",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                      Container(height: 14.0),
                      RateMyAppBuilder(
                        rateMyApp: rate.rateMyApp,
                        onInitialized: (context, rateMyApp) {},
                        builder: (context) => CupertinoButton(
                          onPressed: () {
                            handleRate(context, rate.rateMyApp);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    child: Image(
                                      height: 20,
                                      width: 20,
                                      image: AssetImage("assets/images/rate.png"),
                                      fit: BoxFit.cover
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Đánh giá",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                CupertinoIcons.chevron_right,
                                color: AppColors.grey2,
                              )
                            ],
                          )
                        )
                      ),
                      const Divider(thickness: 1.0),
                      CupertinoButton(
                        onPressed: () {
                          showSnackbar(SnackbarType.notice, "Thông báo", "Đang phát triển");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemContact("assets/images/invite.png", "Mời bạn bè"),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: AppColors.grey2,
                            )
                          ]
                        )
                      ),
                      const Divider(thickness: 1.0,),
                      CupertinoButton(
                        onPressed: () {
                          showSnackbar(SnackbarType.notice, "Thông báo", "Đang phát triển");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemContact("assets/images/feedback.png", "Góp ý"),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: AppColors.grey2,
                            )
                          ],
                        )
                      ),
                      const Divider(thickness: 1.0),
                    ],
                  ),
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget buildOkButton(BuildContext context, double stars) =>
    RateMyAppRateButton(
      rate.rateMyApp,
      text: 'rate-confirm'.tr,
    );
    Widget buildCancelButton() => RateMyAppNoButton(
      rate.rateMyApp,
      text: 'rate-reject'.tr,
    );
    List<Widget> actionsBuilder(BuildContext context, double? stars) =>
    stars == null || stars == 0 ? [buildCancelButton()] : [buildOkButton(context, stars), buildCancelButton()];
    void handleRate(BuildContext context, rate) {
      if (Platform.isIOS) {
        rate.showStarRateDialog(
          context,
          title: "rate".tr,
          message: "rate-message".tr,
          starRatingOptions: const StarRatingOptions(initialRating: 0),
          actionsBuilder: actionsBuilder,
        );
      } else {
        rate.showRateDialog(
          context,
          title: 'Rate this app',
          message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
          rateButton: 'RATE',
          noButton: 'NO THANKS',
          laterButton: 'MAYBE LATER'
        );
      }
    }

  Widget itemContact(String image, String title){
    return Row(
      children: [
        Image(
          height: 20,
          width: 20,
          image: AssetImage(image),
          fit: BoxFit.cover
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ],
    );
  }
}
