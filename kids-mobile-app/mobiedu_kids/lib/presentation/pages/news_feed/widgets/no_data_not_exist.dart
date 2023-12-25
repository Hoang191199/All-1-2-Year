import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';

class NotDataNotExist extends StatelessWidget {
  const NotDataNotExist({
    super.key,
    this.height,
    this.text,
  });

  final double? height;
  final String? text;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: height ?? (heightScreen - statusBarHeight - context.responsive(65.0)),
      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
      child: Center(
        child: Text(
          text ?? 'Liên kết không tồn tại hoặc bạn không có quyền truy cập.',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: context.responsive(14.0), 
              height: context.responsive(1.6), 
              fontWeight: FontWeight.w500, 
              color: HexColor('464646')
            )
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}