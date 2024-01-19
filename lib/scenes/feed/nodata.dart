
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/localization.dart';
import '../../states/settings.dart';


class NoDataInfo extends StatelessWidget {
  final String? title;
  const NoDataInfo({this.title, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(settings.screenWidth / 10.0),
      child: 
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(CupertinoIcons.compass, color: Colors.black26, size: settings.screenWidth / 7.0),
        
        SizedBox(height: settings.screenWidth / 35.0),
        
        Text(title ?? localization('No data'), style: TextStyle(
          color: Colors.black54,
          fontSize: settings.screenWidth / 20.0
        ))
      ])
    );
}

class DeletedComment extends StatelessWidget {
  const DeletedComment({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Text(localization('del.cmnt'), style: TextStyle(
      color: Colors.black38, 
      decoration: TextDecoration.lineThrough
    ));
}

Widget CommentNoData = NoDataInfo(title: localization('no.cmnt'));



