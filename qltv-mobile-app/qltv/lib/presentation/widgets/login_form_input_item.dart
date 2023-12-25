import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';

class LoginFormInputItem extends StatefulWidget {
  const LoginFormInputItem({
    super.key,
    required this.label,
    required this.code,
    required this.inputController,
  });

  final String label;
  final String code;
  final TextEditingController inputController;

  @override
  State<LoginFormInputItem> createState() => _LoginFormInputItemState();
}

class _LoginFormInputItemState extends State<LoginFormInputItem> {
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 24.0),
            Text(widget.label,
                style: GoogleFonts.kantumruy(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black))),
            // const SizedBox(width: 2.0),
            // Container(
            //   margin: const EdgeInsets.only(top: 2.0),
            //   child: const Icon(CupertinoIcons.staroflife_fill, size: 8.0, color: Colors.red),
            // )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          height: 44.0,
          child: TextField(
            controller: widget.inputController,
            obscureText: checkIsPassword() ? isShowPassword : false,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: widget.code == 'phone'
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 24.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('EBE6E8')),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: HexColor('EBE6E8')),
                //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                // ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('EBE6E8')),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: checkIsPassword()
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        child: isShowPassword
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      )
                    : null,
                suffixIconColor: Colors.black38),
            cursorColor: HexColor('7B858B'),
            style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: HexColor('7B858B'),
                    decorationThickness: 0.0)),
            textAlignVertical: TextAlignVertical.center,
          ),
        )
      ],
    );
  }

  bool checkIsPassword() {
    return widget.code == 'password' ||
        widget.code == 'new_password' ||
        widget.code == 're_password';
  }
}
