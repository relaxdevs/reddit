
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class TitleItem extends StatelessWidget {
  final String value;
  const TitleItem(this.value, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Text(value, 
      maxLines: 2, 
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black,
        fontSize: settings.screenWidth / 18.0,
        fontWeight: FontWeight.w500,
      )
    );
}