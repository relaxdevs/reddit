
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/navigator.dart';
import '../../states/settings.dart';


class WebLinkConfirm extends StatelessWidget {
  final String value;
  final void Function()? onBackPressed;
  const WebLinkConfirm(this.value, {required this.onBackPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = settings.screenWidth / 5.5;

    return Container(
      width: settings.screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: settings.screenWidth / 30.0
      ),
      child:
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: EdgeInsets.all(iconSize / 4.0),
          child:
          Icon(CupertinoIcons.globe, size: iconSize * 1.5, color: Colors.black38),
        ),
        Text(value, 
          maxLines: 5, 
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center, 
          style: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: settings.screenWidth / 20.0,
            decoration: TextDecoration.underline
          )
        ),
        
        Container(
          width: settings.screenWidth * 0.7, 
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: iconSize / 2.0,
            bottom: iconSize
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
            CupertinoButton(
              onPressed: onBackPressed,
              child:
              Icon(CupertinoIcons.xmark_rectangle, size: iconSize, color: Colors.black45)
            ),

            CupertinoButton(
              onPressed: () async {
                Uri link = Uri.parse(value);
                
                if (await canLaunchUrl(link)) {
                  launchUrl(link);
                } else {
                  showPopup(context: context);
                }

                onBackPressed?.call();
              },
              child:
              Icon(CupertinoIcons.checkmark_rectangle, size: iconSize, color: Colors.black45)
            )
          ])
        )
      ])
    );
  }
}