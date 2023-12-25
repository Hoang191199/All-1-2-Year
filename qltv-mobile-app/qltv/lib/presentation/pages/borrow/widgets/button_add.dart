import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/pages/borrow/widgets/borrow_add_new.dart';

class ButtonAddDocument extends StatelessWidget {
  const ButtonAddDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
          backgroundColor: AppColors.primary),
        child: Text('add-document'.tr,
          style: GoogleFonts.kantumruy(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700
            )
          )
        ),
        onPressed: () {
          Get.to(() => const BorrowAddNew());
        },
      )
    );
  }
}