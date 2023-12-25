import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../app/extensions/color.dart';

class StepProgressView extends StatelessWidget {
  final double width;
  final List<String> titles;
  final int curStep;
  final Color activeColor;
  final Color inactiveColor = HexColor("#E6EEF3");
  final double lineWidth = 3.0;

  StepProgressView(
      {super.key,
      required this.width,
      required this.titles,
      required this.curStep,
      required this.activeColor});

  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        child: Column(
          children: <Widget>[
            Row(
              children: _iconViews(),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
          ],
        ));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, icon) {
      var circleColor =
          (i == 0 || curStep > i + 1) ? activeColor : inactiveColor;
      var lineColor = curStep > i + 1 ? activeColor : inactiveColor;
      var iconColor = (i == 0 || curStep > i + 1) ? activeColor : inactiveColor;

      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          padding: EdgeInsets.all(0),
          decoration: new BoxDecoration(
            /* color: circleColor,*/
            borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
            border: new Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),
          child: Icon(
            CupertinoIcons.circle,
            color: iconColor,
            size: 12.0,
          ),
        ),
      );

      //line between icons
      if (i != titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, text) {
      list.add(Text(text,
          style: TextStyle(color: Colors.blue
              // HexColor("#000000")
              )));
    });
    return list;
  }
}
