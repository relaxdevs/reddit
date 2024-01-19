
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class NameItem extends StatelessWidget {
  final String value;
  const NameItem(this.value, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: EdgeInsets.symmetric(
        vertical: settings.screenWidth / 50
      ),
      child:
      Text(value, style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black
      ))
    );
}