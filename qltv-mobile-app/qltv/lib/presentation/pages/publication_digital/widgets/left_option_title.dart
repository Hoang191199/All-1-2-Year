import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';

class LeftOptionTitle extends StatelessWidget {
  const LeftOptionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis
          )
        ),
        IconButton(
          onPressed: () {
            handlePressCloseLeftOption(context);
          },
          icon: Icon(CupertinoIcons.back, color: HexColor('7B858B')),
          iconSize: 24.0,
        ),
      ],
    );
  }

  void handlePressCloseLeftOption(BuildContext context) {
    Navigator.of(context).pop();
  }
}