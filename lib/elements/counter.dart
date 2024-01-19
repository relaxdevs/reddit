
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import '../states/localization.dart';
import '../states/navigator.dart' as navigator;
import '../states/settings.dart';


String getReducedValue(int value) => 
  NumberFormat.compact().format(value).toLowerCase();


class CircleCounter extends StatelessWidget {
  final int value;
  final double? size;
  final bool showPlus;
  const CircleCounter(this.value, {this.size, this.showPlus = false, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = this.size ?? settings.screenWidth / 7.5;

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: () => navigator.showPopup(title: localization(showPlus ? 'Karma' : 'Comments'), context: context),
      child:
      Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: showPlus ? Colors.white : Colors.grey.shade200, 
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1
          ),
        ),
        child:
        FittedBox(child:
          Text((showPlus && value > 0 ? '+' : '') + getReducedValue(value), style: TextStyle(
            color: value > 1000 ? Colors.black : Colors.black87,
            fontWeight: value > 1000 ? FontWeight.w500 : null,
          ))
        )
      )
    );
  }
}


class Counter extends StatelessWidget {
  final int value;
  final void Function()? onPressed;
  const Counter(this.value, {this.onPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: onPressed,
      child:
      Text((value > 0 ? '+' : '') + getReducedValue(value), style: TextStyle(
        fontSize: settings.screenWidth / 24.0,
        color: Colors.black38
      ))
    );
}