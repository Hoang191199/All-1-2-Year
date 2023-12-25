import 'package:flutter/material.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

class CircleContainAsset extends StatelessWidget {
  const CircleContainAsset({
    super.key,
    required this.radius,
    required this.backgroundColor,
    required this.linkAsset,
    required this.sizeAsset,
  });

  final double radius;
  final String backgroundColor;
  final String linkAsset;
  final double sizeAsset;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: HexColor(backgroundColor),
      child: Center(
        child: Image.asset(
          linkAsset,
          width: sizeAsset,
          height: sizeAsset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}