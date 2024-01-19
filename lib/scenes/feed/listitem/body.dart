
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class BodyItem extends StatelessWidget {
  final String value;
  const BodyItem(this.value, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Text(value,
      maxLines: 5, 
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black87,
        fontSize: settings.screenWidth / 22.0,
        height: 1.3
      )
    );
}