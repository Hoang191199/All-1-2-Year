import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';

class DialogReadTimer extends StatelessWidget {
  const DialogReadTimer({
    super.key,
    required this.readTimer,
  });

  final int readTimer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'attention'.tr,
              style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: HexColor('333333'))),
            ),
            const SizedBox(height: 16.0),
            Text(
              '${"read-beyond-message".tr} ${getTextTime()}.',
              style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: HexColor('333333'))),
            ),
            Text(
              'rest-message'.tr,
              style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: HexColor('333333'))),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              'assets/images/read_timer.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  String getTextTime() {
    var textTime = '';
    if (readTimer < 60) {
      return '$readTimer ${"seconds".tr.toLowerCase()}';
    } else {
      final seconds = readTimer % 60;
      seconds > 0
        ? textTime = '${(readTimer / 60).floor()} ${"minute".tr.toLowerCase()} $seconds ${"seconds".tr.toLowerCase()}'
        : textTime = '${(readTimer / 60).round()} ${"minute".tr.toLowerCase()}';
    }
    return textTime;
  }
}
