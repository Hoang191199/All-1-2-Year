import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class NoAssignment extends StatelessWidget {
  NoAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 58.0),
      padding: const EdgeInsets.symmetric(vertical: 63.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset('assets/images/no_assig.png',
            width: widthScreen,
            height: 249.0,
          ),
          const SizedBox(height:38.0),
          Text('Bạn chưa được phân công \n vào lớp đón muộn',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ]
      ),
    );
  }
}
