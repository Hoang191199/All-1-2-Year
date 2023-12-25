import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: HexColor('FFFFFF'),
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/notification-bell-yellow.png',
              width: 24.0,
              height: 24.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Thông báo',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 16.0, height: 1.5, fontWeight: FontWeight.w700, color: HexColor('464646'))
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    content,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 14.0, height: 1.6, fontWeight: FontWeight.w500, color: HexColor('464646'))
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40.0,
                        height: 24.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            backgroundColor: HexColor('5DD89D'),
                            padding: const EdgeInsets.all(0.0)
                          ),
                          child: Text(
                            'OK',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: HexColor('FFFFFF'))
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, 'OK'), 
                        ),
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}