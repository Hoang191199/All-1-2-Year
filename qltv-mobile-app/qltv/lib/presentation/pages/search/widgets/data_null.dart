import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchDataNull extends StatelessWidget {
  SearchDataNull({super.key, this.title});

  String? title;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return SizedBox(
      height: heightScreen / 2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          'assets/svg/search.svg',
          width: 191,
          height: 160,
        ),
        Text(title ?? '',
            style: GoogleFonts.kantumruy(
              textStyle: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )),
      ]),
    );
  }
}
