import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    this.type
  });

  final String? type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Text(
          type == 'menu' ? "Thực đơn trống" : "Lịch học trống",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color:AppColors.primary,
              fontWeight: FontWeight.w700
            )
          ),
        )
      ),
    );
  }
}