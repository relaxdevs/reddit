
import 'package:flutter/material.dart';

import '../../states/localization.dart';

import '../feed/nodata.dart';


Widget CommentNoData = NoDataInfo(title: localization('no.cmnt'));

class DeletedComment extends StatelessWidget {
  const DeletedComment({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Text(localization('del.cmnt'), style: TextStyle(
      color: Colors.black38, 
      decoration: TextDecoration.lineThrough
    ));
}





