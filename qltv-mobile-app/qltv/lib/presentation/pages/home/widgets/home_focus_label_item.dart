import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';

class HomeFocusLabelItem extends StatelessWidget {
  HomeFocusLabelItem({
    super.key,
    required this.index,
    required this.name,
  });

  final int index;
  final String name;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.changeIndexModelFocus(index);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: HexColor('FAFAFA'),
            border: Border.all(color: homeController.indexModelFocus.value == index ? HexColor('7B858B') : HexColor('F0F0F0')),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(
            child: Text(
              name,
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                  fontSize: 14.0,
                  height: 1.4,
                  fontWeight: FontWeight.w400, 
                  color: homeController.indexModelFocus.value == index ? AppColors.primaryBlue : HexColor('7B858B')
                )
              )
            ),
          ) ,
        )
      ),
    );
  }
}