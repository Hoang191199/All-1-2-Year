import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferPeriod extends StatelessWidget {
  const OfferPeriod({
    super.key,
    required this.dayNumber,
  });

  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(CupertinoIcons.speedometer, color: Colors.green, size: 22.0),
        const SizedBox(width: 10.0),
        Text(
          'Thời gian ưu đãi còn $dayNumber ngày', 
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}