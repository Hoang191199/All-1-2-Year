import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class FormHealth extends StatelessWidget {
  const FormHealth({
    super.key,
    required this.title,
    required this.text,
    required this.type,
  });

  final String title; 
  final TextEditingController text; 
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Row(
            children: [
              const Expanded(
                child: SizedBox()
              ),
              Text(
                "$title: ",
                style: GoogleFonts.raleway(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black
                ),
              ),
            ]
          )
        ),
        Expanded(
          child: CupertinoTextField(
            controller: text,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent
              )
            ),
          )
        ),
        if(type != '')
        Text(
          type,
          style: GoogleFonts.raleway(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.grey
          ),
        ),
      ],
    );
  }
}