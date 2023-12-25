import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';

class ProgressReading extends StatelessWidget {
  ProgressReading({
    super.key,
    required this.percentReading,
  });

  final int percentReading;

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: HexColor('DFD9D9'),
            borderRadius: const BorderRadius.all(Radius.circular(2.0))
          ),
          child: Row(
            children: [
              Container(
                width: percentReading * 60 / 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(2.0))
                ),
                child: const Text(''),
              ),
            ],
          )
        ),
        const SizedBox(width: 8.0),
        Container(
          margin: const EdgeInsets.only(right: 6.0),
          child: Text(
            '$percentReading%',
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(fontSize: 10.0, height: 1.7, fontWeight: FontWeight.w400, color: HexColor('343232'))
            )
          ),
        ),
      ],
    );
  }
}