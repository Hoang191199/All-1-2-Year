import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class ItemShuttle extends StatelessWidget {
  ItemShuttle({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  });

  final String title;
  final String description;
  final String icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => page);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(8.0)
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 54.0,
              height: 54.0,
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        height: 1.5
                      ),
                    ),
                  ),
                  Text(
                    description,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        height: 1.5
                      ),
                    ),
                    softWrap: true,
                  )
                ],
              )
            )
          ]
        ),
      )
    );
  }
}
