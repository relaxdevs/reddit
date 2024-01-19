
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class WrapItem extends StatelessWidget {
  final Widget? child;
  const WrapItem({this.child, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(
        minHeight: settings.screenWidth / 4.0
      ),
      margin: EdgeInsets.symmetric(
        vertical: settings.screenWidth / 35.0,
        horizontal: settings.screenWidth / 25.0,
      ), 
      padding: EdgeInsets.symmetric(
        vertical: settings.screenWidth / 18.0,
        horizontal: settings.screenWidth / 23.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(settings.screenWidth / 30))
      ),
      child: child
    );
}