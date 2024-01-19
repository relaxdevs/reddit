
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../states/settings.dart';


class BodyItem extends StatelessWidget {
  final String value;
  final int? maxLines;
  const BodyItem(this.value, {this.maxLines, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Text(value,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: settings.screenWidth / 23.0,
        height: 1.3
      )
    );
}