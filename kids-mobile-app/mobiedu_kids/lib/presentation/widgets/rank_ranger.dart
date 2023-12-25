import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class RankRanger extends StatelessWidget {
  const RankRanger({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w500                                      
        ),
      ),
    );
  }
}