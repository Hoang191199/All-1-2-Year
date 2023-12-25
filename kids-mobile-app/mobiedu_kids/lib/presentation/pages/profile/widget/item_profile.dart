import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class ItemProfile extends StatelessWidget {
  const ItemProfile({
    super.key,
    required this.image, 
    required this.title, 
  });

  final String image; 
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              child: Image(
                height: 20,
                width: 20,
                image: AssetImage(image),
                fit: BoxFit.contain
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ],
        ),
        Icon(
          CupertinoIcons.chevron_right,
          color: AppColors.grey2,
        )
      ],
    );
  }
}