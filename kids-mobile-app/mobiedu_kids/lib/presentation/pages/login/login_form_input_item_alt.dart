import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

class LoginFormInputItem2 extends StatefulWidget {
  const LoginFormInputItem2({
    super.key,
    required this.label,
    required this.code,
    required this.inputController,
  });

  final String label;
  final String code;
  final TextEditingController inputController;

  @override
  State<LoginFormInputItem2> createState() => _LoginFormInputItem2State();
}

class _LoginFormInputItem2State extends State<LoginFormInputItem2> {
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 40.0),
            Text(widget.label,
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold, 
                  color: Colors.black
                )
              )
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0,left: 28,right: 28),
          height: 44.0,
          child: TextField(
            controller: widget.inputController,
            obscureText: checkIsTypePassword() ? true : checkIsPassword() ? isShowPassword : false,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: widget.code == 'phone' ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('EBE6E8')),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('EBE6E8')),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              suffixIcon: checkIsPassword() ? 
              GestureDetector(
                onTap: () {
                  setState(() {isShowPassword = !isShowPassword;});
                },
                child: isShowPassword ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye),
              ) : 
              null,
              suffixIconColor: Colors.black38
            ),
            cursorColor: HexColor('7B858B'),
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 16.0,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: HexColor('7B858B'),
                decorationThickness: 0.0
              )
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        )
      ],
    );
  }

  bool checkIsPassword() {
    return widget.code == 'password' ;
  }

  bool checkIsTypePassword() {
    return  widget.code == 'new_password' || widget.code == 're_password';
  }
}
