import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningCard extends StatelessWidget {
  late int index;

  LearningCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<String> card =  [
      'assets/images/card/card_chi.jpg',
      'assets/images/card/card_eng.jpg',
      'assets/images/card/card_kor.jpg',
      'assets/images/card/card_jap.jpg',
      'assets/images/card/card_200k.jpg',
      'assets/images/card/card_1mil.jpg',
      'assets/images/card/card_grow.jpg',
      'assets/images/card/card_lea.jpg',
      'assets/images/card/card_des.jpg',
    ];
    return Container(
      child: Image.asset(
        card[index],
        width: 400.0,
        height: 300.0,
        fit: BoxFit.fill,
      ),
    );
  }
}