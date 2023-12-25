import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoBookcaseData extends StatelessWidget {
  const NoBookcaseData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80.0),
          child: Image.asset(
            'assets/images/bookcase_nodata.png',
            width: 250.0,
            height: 250.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 28.0),
          child: Text('let-add'.tr,
              style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
        )
      ],
    );
  }
}
