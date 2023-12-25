import 'package:flutter/material.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';

class HorizontalDividerNoPadding extends StatelessWidget {
  const HorizontalDividerNoPadding({
    super.key,
    this.color
  });

  final String? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: HexColor(color != null && (color?.isNotEmpty ?? false) ? color ?? '' : 'D8D8D8')))
      )
    );
  }
}