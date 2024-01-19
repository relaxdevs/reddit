
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class RepliesButton extends StatelessWidget {
  final int count;
  final void Function()? onPressed;
  const RepliesButton(this.count, {this.onPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      alignment: Alignment.centerRight, 
      child:
      CupertinoButton(
        onPressed: onPressed,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
          Icon(CupertinoIcons.reply_all, 
            size: settings.screenWidth / 15.0, 
            color: Colors.black38
          ),
          SizedBox(width: settings.screenWidth / 80.0),
          Text('$count', style: TextStyle(
            color: Colors.black38,
            fontSize: settings.screenWidth / 22.0
          ))
        ])
      )
    );
}