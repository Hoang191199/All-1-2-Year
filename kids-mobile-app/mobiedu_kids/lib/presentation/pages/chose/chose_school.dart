import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/chose/widget/item_chose_school.dart';

class ChoseSchool extends StatelessWidget {
  ChoseSchool({super.key});

  final splashController = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          padding: const EdgeInsetsDirectional.only(top: 12.0),
          middle: Text(
            'Chọn trường',
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
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: splashController.responseManagerData.value?.data?.schools?.length,
                  itemBuilder: (context, index) => ItemChoseSchool(
                    school: splashController.responseManagerData.value?.data?.schools?[index],
                  )
                ),
              )
            ],
          )
        )
      )
    );
  }
}
