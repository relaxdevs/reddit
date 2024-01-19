
import 'package:flutter/material.dart';

import '../../states/localization.dart';
import '../../states/settings.dart';

import '../modal/main.dart' show interpolate;


class PopupInfo extends StatefulWidget {
  final String? title;
  final Function onBackPressed;
  const PopupInfo({this.title, required this.onBackPressed, Key? key}): super(key: key);
  
@override
  _PopupInfoState createState() => _PopupInfoState();
}

class _PopupInfoState extends State<PopupInfo> with TickerProviderStateMixin {
  late AnimationController controller;
  late Function interpolated;
  Curve curve = Curves.easeOut;

  void onStatusListener(AnimationStatus listener) {
    if (listener == AnimationStatus.completed) {
      if (controller.value == 0.5) {
        controller.animateTo(1.0, duration: Duration(milliseconds: 1500), curve: curve);
      } else {
        controller.animateBack(0.0, curve: curve);
      }
    }
    if (listener == AnimationStatus.dismissed) {
      widget.onBackPressed();
    }
  }

  @override
  void initState() {
    interpolated = interpolate([0.0, 0.5, 1.0], [0.0, 1.0, 1.0]);

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150))
      ..addListener(() => mounted ? setState((){}) : null)
      ..addStatusListener(onStatusListener)
      ..animateTo(0.5, curve: curve);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Transform.scale(
      scale: controller.status == AnimationStatus.reverse ? 1.0 : interpolated(controller.value), 
      child:
      Opacity(
        opacity: interpolated(controller.value),
        child: 
        Container(
          alignment: Alignment.center,
          child:
          Container(
            padding: EdgeInsets.symmetric(
              vertical: settings.screenWidth / 15.0,
              horizontal: settings.screenWidth / 12.0
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(settings.screenWidth / 40.0)),
              color: Colors.black54
            ),
            child:
            Text(widget.title ?? localization('err'),
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: settings.screenWidth / 20.0, 
                color: Colors.white
              )
            )
          )
        )
      )
    );
}