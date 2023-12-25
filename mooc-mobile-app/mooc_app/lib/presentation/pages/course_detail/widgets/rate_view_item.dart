import 'package:flutter/material.dart';
import 'package:mooc_app/app/config/app_common.dart';

class RateViewItem extends StatelessWidget {
  const RateViewItem({
    super.key,
    required this.starFillNumber,
    required this.ratePercent,
  });

  final double starFillNumber;
  final int ratePercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Container(
            width: 152.0,
            height: 8.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: const BorderRadius.all(Radius.circular(5.0))
            ),
            child: Row(
              children: [
                Container(
                  width: ratePercent * 150 / 100,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: const Text(''),
                ),
              ],
            )
          ),
          const SizedBox(width: 10.0),
          Row(children: getListStarViewOfFive(starFillNumber)),
          SizedBox(
            width: 80.0, 
            child: Text('$ratePercent%', style: const TextStyle(fontSize: 14.0, color: Colors.black), textAlign: TextAlign.end)
          ),
        ],
      )
    );
  }
}