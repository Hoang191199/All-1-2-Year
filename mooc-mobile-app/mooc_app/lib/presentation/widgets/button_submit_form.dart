import 'package:flutter/material.dart';

class ButtonSubmitForm extends StatelessWidget {
  const ButtonSubmitForm({
    super.key,
    required this.buttonText,
    required this.formKey
  });

  final String buttonText;
  final GlobalKey<FormState> formKey;

//   @override
//   State<ButtonSubmitForm> createState() => _ButtonSubmitFormState();
// }
//
// class _ButtonSubmitFormState extends State<ButtonSubmitForm> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: () {
      //   if (widget.formKey.currentState!.validate()) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Ok'))
      //     );
      //   }
      // },
      onPressed: null,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        disabledBackgroundColor: Colors.white54
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(buttonText),
      )
    );
  }
}