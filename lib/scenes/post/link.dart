
import 'package:flutter/cupertino.dart';

import '../../states/settings.dart';


class LinkItem extends StatelessWidget {
  final String value;
  final void Function()? onPressed;
  const LinkItem(this.value, {this.onPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: onPressed,
      child:
      Text(value,
        style: TextStyle(
          color: CupertinoColors.activeBlue,
          fontSize: settings.screenWidth / 20.0,
          decoration: TextDecoration.underline
        )
      )
    );
}