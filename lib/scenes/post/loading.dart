
import 'package:flutter/material.dart';

import '../../states/settings.dart';


class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      margin: EdgeInsets.all(settings.screenWidth / 23.0),
      child:
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
          width: settings.screenWidth / 4.5,
          height: settings.screenWidth / 4.5, 
          color: Colors.grey.shade100
        ),

        SizedBox(height: settings.screenWidth / 30),

        Container(
          width: settings.screenWidth * 0.8, 
          height: settings.screenWidth * 0.9, 
          color: Colors.grey.shade100
        ), 
      ])
    );
}
