import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.icon,
    required this.labelText
  });

  final Icon icon;
  final String labelText;

//   @override
//   State<TextInput> createState() => _TextInputState();
// }
//
// class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70)
        ),
        filled: true,
        fillColor: Colors.black26,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: icon,
        ),
      ),
      style: const TextStyle(color: Colors.white70),
      cursorColor: Colors.white70,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field null';
        }
        return null;
      },
    );
  }
}