import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';

class ContactFormInputItem extends StatelessWidget {
  const ContactFormInputItem({
    super.key,
    required this.label,
    required this.code,
    required this.inputController,
  });

  final String label;
  final String code;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.responsive(12.0)),
          child: Text(
            '$label:', 
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
            )
          ),
        ),
        SizedBox(height: context.responsive(8.0)),
        TextField(
          controller: inputController,
          keyboardType: code == 'phone' ? TextInputType.number : TextInputType.text,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('D8D8D8'))
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('D9D9D9')),
              borderRadius: BorderRadius.all(Radius.circular(context.responsive(8.0))),
            ),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(color: HexColor('FF9ACE')),
            //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            // ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('D9D9D9')),
              borderRadius: BorderRadius.all(Radius.circular(context.responsive(8.0))),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: context.responsive(5.0), horizontal: context.responsive(12.0)),
          ),
          cursorColor: HexColor('464646'),
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('464646'), decorationThickness: 0.0)
          ),
          minLines: code == 'studentInfo' ? 5 : 1,
          maxLines: code == 'studentInfo' ? 5 : 1,
        )
      ],
    );
  }
}