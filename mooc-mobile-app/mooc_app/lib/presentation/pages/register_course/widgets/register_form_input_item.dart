import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterFormInputItem extends StatelessWidget {
  const RegisterFormInputItem({
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
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12.0, color: Colors.black)),
              const SizedBox(width: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                child: const Icon(CupertinoIcons.staroflife_fill, size: 7.0, color: Colors.red),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextField(
              controller: inputController,
              keyboardType: code == 'phone' ? TextInputType.number : TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                contentPadding: EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              cursorColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}