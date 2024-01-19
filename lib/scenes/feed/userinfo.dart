
import 'package:flutter/material.dart';

import '../../states/settings.dart';

import '../../models/user.dart';

import '../../elements/avatar.dart';
import '../../elements/counter.dart';


class UserInfo extends StatelessWidget {
  final UserModel item;
  final EdgeInsets? padding;
  final void Function()? onUserPressed;
  const UserInfo(this.item, {this.padding, this.onUserPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = settings.screenWidth / 3.0;

    return Container(
      padding: padding,
      child:
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(child: SizedBox()),
          Container(
            width: size, 
            height: size, 
            child:
            UserAvatar(item.avatar, 
              size: size,
              onPressed: item.avatar != null ? onUserPressed : null,
            )
          ),
          Expanded(child:
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: settings.screenWidth / 20.0
              ),
              child:
              CircleCounter(item.score, 
                showPlus: true,
                size: settings.screenWidth / 6.0
              )
            )
          )
        ]),
        
        Padding(
          padding: EdgeInsets.only(
            top: settings.screenWidth / 50.0,
            bottom: settings.screenWidth / 15.0
          ), 
          child:
          Text(item.name, style: TextStyle(
            color: Colors.black,
            fontSize: settings.screenWidth / 20.0
          ))
        )
      ])
    );
  }
}