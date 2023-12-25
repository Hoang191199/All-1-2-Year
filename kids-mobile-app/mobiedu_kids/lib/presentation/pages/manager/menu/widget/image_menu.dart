import 'package:flutter/material.dart';

class ImageMenu extends StatelessWidget {
  const ImageMenu({
    super.key,
    required this.image
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return Image.asset(
      image,
      width: ((widthScreen - 56) / 3) / 2,
      height: 75.0,
      fit: BoxFit.contain,
    );
  }
}