import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class MealName extends StatelessWidget {
  const MealName({
    super.key,
    this.title,
    this.checkColor
  });

  final String? title;
  final bool? checkColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0), 
      child: Text(title ?? '', 
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            color: AppColors.primary, 
            fontWeight:checkColor == false ? FontWeight.w700 : FontWeight.w500,
            fontSize :checkColor == false ? 14.0 : 12.0
          )
        )
      )
    );
  }
}