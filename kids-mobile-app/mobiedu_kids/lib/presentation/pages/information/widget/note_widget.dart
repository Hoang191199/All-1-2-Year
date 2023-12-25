import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget({super.key, required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPink2),
        borderRadius: const BorderRadius.all(Radius.circular(14.0))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset('assets/images/note-info.png', 
                width: 24.0, 
                height: 24.0, 
                fit: BoxFit.contain,
              ),
              Text('Ghi chú', 
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    height: 1.5
                  ),
                )
              )
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Text(note,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            )
          )
        ],
      ),
    );
  }
}
