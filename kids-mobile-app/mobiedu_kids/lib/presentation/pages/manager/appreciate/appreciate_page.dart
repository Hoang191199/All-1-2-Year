import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class AppreciatePage extends StatelessWidget {
  const AppreciatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 12.0),
          leading: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.back),
            ),
          ),
          middle: Text(
            'Đánh giá',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: Colors.white,
          border: const Border(),
        ),
        child: Column(
          children: [],
        ));
  }
}
