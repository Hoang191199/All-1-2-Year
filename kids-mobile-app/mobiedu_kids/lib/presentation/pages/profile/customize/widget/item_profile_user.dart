import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';

class ItemProfileUser extends StatelessWidget {
  const ItemProfileUser({
    super.key,
    required this.image,
    required this.textController,
    required this.placeholderText,
    this.checkPassword
  });

  final String image;
  final String placeholderText;
  final TextEditingController textController;
  final bool? checkPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
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
          Expanded(
            child: CupertinoTextField(
              controller: textController,
              obscureText: checkPassword == true ? true : false,
              placeholder: placeholderText,
              placeholderStyle: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 14.0,
                  fontWeight:FontWeight.w700
                ),
              ),
              decoration: const BoxDecoration(
                border: Border()
              ),
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight:FontWeight.w700
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}