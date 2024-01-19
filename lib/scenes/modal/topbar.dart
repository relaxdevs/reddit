
import 'package:flutter/material.dart';

import '../../states/settings.dart';


class TopNavBar extends StatelessWidget {
  const TopNavBar({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      width: settings.screenWidth / 7.5,
      height: settings.screenWidth / 130,
      margin: EdgeInsets.only(
        top: settings.screenWidth / 75.0,
        bottom: settings.screenWidth / 60
      ), 
      decoration: BoxDecoration(
        color: Colors.black12, 
        borderRadius: BorderRadius.all(Radius.circular(settings.screenWidth / 3.5))
      )
    );
}