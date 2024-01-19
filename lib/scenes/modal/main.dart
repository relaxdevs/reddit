
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

import '../../states/settings.dart';
import './topbar.dart';


Function interpolate(List<double> arr1, List<double> arr2) {
  return (double value) {
    int index = arr1.indexWhere((item) => item >= value);
    int indexMin = index == 0 ? 0 : index == -1 ? arr1.length - 2 : index - 1;
    int indexMax = index == 0 ? 1 : index == -1 ? arr1.length - 1 : index;

    double percent = (value - arr1[indexMin]) / (arr1[indexMax] - arr1[indexMin]);
    double result = ui.lerpDouble(arr2[indexMin], arr2[indexMax], percent) ?? 0.0;

    return result;
  };
}


bool isDoubleNear(double n1, double n2) => (n1 - n2).abs() < 0.1;


class ModalWrap extends StatefulWidget {
  final Widget? child;
  final Function? builder;
  final Widget? topLeftChild;
  final double? middleControllerValue;
  final bool? showBackButton;
  final bool? closeOnBackButtonPressed;
  final Function? onScrollEnd;
  final Function onBackPressed;
  const ModalWrap({this.child, this.builder, this.topLeftChild, this.middleControllerValue, this.showBackButton, this.closeOnBackButtonPressed, this.onScrollEnd, required this.onBackPressed, Key? key}): super(key: key);
  
@override
  _ModalWrapState createState() => _ModalWrapState();
}

class _ModalWrapState extends State<ModalWrap> with TickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  late AnimationController controller;
  late AnimationController menuController;
  ScrollController? childScrollController;
  late Function interpolatedOffset;
  late Function interpolatedOpacity;
  late double middleControllerValue;
  double offset = settings.screenHeight;
  bool flag = false;
  bool flagPopup = false;
  bool flagTopLeftChild = true;
  double flagTopLeftChildOffset = 0.0;

  bool get isUpperPosition => isDoubleNear(controller.value, 1.0);
  bool get isMiddlePosition => isDoubleNear(controller.value, middleControllerValue);

  void onScrollController(ScrollController c) {
    childScrollController = c;
  }

  void animateMenuPosition(bool f) {
    if (f && menuController.status != AnimationStatus.forward) menuController.animateTo(1.0, curve: Curves.easeInOut);
    else if (!f && menuController.status != AnimationStatus.reverse) menuController.reverse();
  }

  void animateController(double n) {
    if (n > 0.0) {
      controller.animateTo(n, curve: n == 1.0 ? Curves.easeInOut : Curves.ease);
    } else {
      controller.animateBack(n, curve: Curves.ease);
    }
  }

  void changeOffset(double n) {
    offset = offset + n;
    if (mounted) setState((){});
  }

  bool onNotification(scrollNotification) {
    if (controller.isAnimating) return false;

    if (widget.topLeftChild != null && scrollNotification.metrics.axis == Axis.horizontal && scrollNotification is ScrollUpdateNotification) {
      if (scrollNotification.depth == 1) {
        bool f = isDoubleNear(0.0, scrollNotification.metrics.pixels);
        
        if (f != flagTopLeftChild) {
          flagTopLeftChild = f;  

          if (isUpperPosition) {
            if (mounted) setState((){});
          }
        }
      }

      return false;
    }

    if (scrollNotification.metrics.axis == Axis.horizontal) return false;

    if (scrollNotification.depth == 2 && scrollNotification is ScrollStartNotification) {
      animateMenuPosition(true);
    }
    
    if (scrollNotification is ScrollEndNotification) {
      if (scrollNotification.depth == 2) {
        animateMenuPosition(false);
      }
      
      if (scrollNotification.depth > 0) {
        flagPopup = false;
        if (isUpperPosition || isMiddlePosition) {
          flag = false;
        }
      }
    }

    if (scrollNotification is ScrollUpdateNotification) {
      if (isUpperPosition && widget.topLeftChild != null && scrollNotification.depth == 2) {
        double n = flagTopLeftChildOffset;
        flagTopLeftChildOffset = scrollNotification.metrics.pixels;

        if (scrollNotification.depth == 2) {
          if ((n <= 100 && flagTopLeftChildOffset > 100) || (n > 100 && flagTopLeftChildOffset <= 100)) {
            if (mounted) setState((){});
          }
        }
      }

      if (flag) return false;

      if (widget.onScrollEnd != null && !flagPopup && controller.value > middleControllerValue && scrollNotification.depth > 0 && scrollNotification.metrics.pixels > (scrollNotification.metrics.maxScrollExtent + 50.0)) {
        flagPopup = true;
        if (widget.showBackButton != false) widget.onScrollEnd!();
      }

      if (!flag && scrollNotification.metrics.pixels > 10) {
        flag = true;
        animateController(1.0);
        
      } else if (scrollNotification.metrics.pixels < -80 || (scrollNotification.scrollDelta ?? 0.0) < -80) {
          flag = true;
          
          animateController((widget.closeOnBackButtonPressed != true && controller.value > middleControllerValue) ? middleControllerValue : 0.0);
      } else if (scrollNotification.metrics.pixels <= 0) {
        controller.value = controller.value + (scrollNotification.scrollDelta ?? 0.0) / 1000;
        if (mounted) setState((){});
      }
    }

    return false;
  }

  @override
  void initState() {
    middleControllerValue = widget.middleControllerValue ?? 0.7;

    interpolatedOffset = interpolate([0.0, 1.0], [settings.screenHeight, 0.0]);
    interpolatedOpacity = interpolate([0.0, 1.0], [0.0, 0.12]);

    menuController = AnimationController(vsync: this,value:1.0, duration: Duration(milliseconds: 150))
      ..addListener(() => mounted ? setState((){}) : null);

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: middleControllerValue == 1.0 ? 200 : 350))
      ..addListener(() {
        offset = interpolatedOffset(controller.value);
        if (mounted) setState((){});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          widget.onBackPressed();
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
      interpolatedOffset = interpolate([0.0, 1.0], [box.size.height, 0.0]);

      animateController(middleControllerValue);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Container(
      child:
      Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        GestureDetector(
          onTap: () => animateController(0.0),
          child:
          Container(
            color: Colors.black.withOpacity(interpolatedOpacity(controller.value))
          )
        ),

        Transform.translate(
          offset: Offset(0, offset),
          child: 
          NotificationListener<ScrollNotification>(
            onNotification: onNotification,
            child:
            Container( 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
              ),
              child:
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child:
                Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  
                  if (controller.value != 1.0 && widget.middleControllerValue != 1.0)
                    GestureDetector(
                      onVerticalDragUpdate: controller.isAnimating ? null : (DragUpdateDetails d) { 
                        controller.value = min(middleControllerValue, controller.value - (d.delta.dy / 1000));
                        if (controller.value < 0.45) {
                          animateController(0.0);
                        } else {
                          if (mounted) setState((){});
                        }
                      },
                      onVerticalDragEnd: controller.isAnimating ? null : (_) => animateController(middleControllerValue),
                      child:
                      Container(
                        width: settings.screenWidth,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child:
                        TopNavBar()
                      )
                    ),

                  
                  Flexible(child: Container(
                    key: globalKey,
                    child: widget.builder != null 
                      ? widget.builder!(context, isUpperPosition, onScrollController, animateController)
                      : widget.child
                  ))
                ])
              )
            )
          )
        ),



        if (widget.topLeftChild != null && isUpperPosition) 
          AnimatedPositioned(
            top: (settings.viewPadding.top / 2.0) + (settings.screenWidth / 30.0) + (flagTopLeftChild && flagTopLeftChildOffset > 100.0 ? 0.0 : -200.0), 
            left: settings.screenWidth / 20.0, 
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child:
            Transform.translate(
              offset: Offset(0, -menuController.value * (settings.screenWidth / 6.5)),
              child: widget.topLeftChild
            )
          ),
          

        if (widget.showBackButton != false && controller.value > middleControllerValue)
          Positioned(
            left: 0,
            child:
            Transform.translate(
              offset: Offset(0, menuController.value * (settings.screenWidth / 6.5)),
              child:
              CupertinoButton(
                onPressed: () {
                  if (widget.closeOnBackButtonPressed != true && childScrollController?.hasClients == true) {
                    childScrollController!.jumpTo(0.0);
                    flag = false;
                  }
                  
                  animateController(widget.closeOnBackButtonPressed != true ? middleControllerValue : 0.0);
                },
                child:
                Container(
                  color: Colors.white70,
                  child:
                  Icon(CupertinoIcons.chevron_compact_left, color: Colors.black, size: settings.screenWidth / 6.5)
                )
              )
            )
        )
      ])
    );
}