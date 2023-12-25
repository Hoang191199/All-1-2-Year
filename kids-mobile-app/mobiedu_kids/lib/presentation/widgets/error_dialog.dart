import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thông báo',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: HexColor('783199'))
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Có lỗi xảy ra. Vui lòng thử lại.',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: HexColor('464646'))
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100.0,
                  height: 38.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.until((route) => !Get.isDialogOpen!);
                      // Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      elevation: 0.0,
                      backgroundColor: HexColor('5DD89D'),
                      textStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                      )
                    ),
                    child: const Text('OK')
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}