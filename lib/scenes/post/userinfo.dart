
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/settings.dart';

import '../../models/feeditem.dart';

import '../../elements/counter.dart';
import '../../elements/avatar.dart';


class UserCountersInfo extends StatelessWidget {
  final FeedItemModel item;
  final void Function()? onUserPressed;
  const UserCountersInfo(this.item, {this.onUserPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(item.author.name),
          
          SizedBox(height: settings.screenWidth / 50.0),
          
          UserAvatar(item.author.avatar, 
            onPressed: (item.author.avatar != null || item.author.banned) ? onUserPressed : null
          ),
      ]),

      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        if (item.score != 0)
          CircleCounter(item.score, showPlus: true),

        if (item.countComments > 0)
          Padding(
            padding: EdgeInsets.only(
              left: settings.screenWidth / 100.0
            ),
            child:
            CircleCounter(item.countComments)
          )
      ])
    ]);
}