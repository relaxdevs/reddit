
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NoAnimationCupertinoRoute<T> extends CupertinoModalPopupRoute<T> {
  NoAnimationCupertinoRoute({required WidgetBuilder builder}) : super(builder: builder);
  
  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Color get barrierColor => Colors.transparent;

  @override
  Widget buildTransitions(_, __, ___, child) => child;
}