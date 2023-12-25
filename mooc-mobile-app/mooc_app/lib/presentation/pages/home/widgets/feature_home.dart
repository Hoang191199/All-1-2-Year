import 'package:flutter/material.dart';
import 'package:mooc_app/app/types/feature_type.dart';
import 'package:mooc_app/presentation/pages/home/widgets/feature_item.dart';

class FeatureHome extends StatelessWidget {
  const FeatureHome({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return Container(
      width: widthScreen,
      margin: const EdgeInsets.only(top: 36.0, bottom: 36.0),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: FeatureType.values
          .map((e) => FeatureItem(icon: e.icon, title: e.title(context), type: e.type, color: e.color))
          .toList(),
      ),
    );
  }
}