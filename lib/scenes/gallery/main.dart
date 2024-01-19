
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../states/settings.dart';

import '../../elements/dots/main.dart';
import '../../elements/cachedimage.dart';


class MediaGallery extends StatefulWidget {
  final int? index;
  final String? link; 
  final List<String>? data;
  final Function? onPageChanged;
  final Function onBackPressed;
  const MediaGallery({this.index, this.link, this.data, this.onPageChanged, required this.onBackPressed, Key? key}): super(key: key);
  
@override
  _MediaGalleryState createState() => _MediaGalleryState();
}

class _MediaGalleryState extends State<MediaGallery> {
  late PageController controller;
  late int page;
  double opacity = 0.0;
  bool flag = false;

  void onPageChanged(int n) {
    page = n;
    if (mounted) setState((){});

    widget.onPageChanged?.call(n);
  }

  void changeOpacity(double n) {
    opacity = n;
    if (mounted) setState((){});
  }

  void onEnd() {
    if (opacity == 0.0) widget.onBackPressed();
  }

  @override
  void initState() {
    page = widget.index ?? 0;
    controller = PageController(initialPage: page);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeOpacity(1.0);
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
    GestureDetector(
      onTap: () {
        flag = !flag;
        if (mounted) setState((){});
      },
      onVerticalDragEnd: (DragEndDetails d) {
        if (d.velocity.pixelsPerSecond.dy > 1000) {
          changeOpacity(0.0);
        } 
      },
      child:
      AnimatedOpacity(
        duration: Duration(milliseconds: 100),
        opacity: opacity,
        curve: Curves.easeInOut,
        onEnd: onEnd,
        child:
        Container(
          width: settings.screenWidth,
          height: settings.screenHeight,
          color: Colors.black,
          alignment: Alignment.center,
          child: 
          Stack(alignment: Alignment.center, children: <Widget>[
            PageView.builder(
              controller: controller,
              onPageChanged: onPageChanged,
              scrollDirection: Axis.horizontal,
              itemCount: max(1, widget.data?.length ?? 0),
              itemBuilder: (BuildContext context, int i) =>
                CachedImage(widget.data?.isNotEmpty == true ? widget.data![i] : widget.link!, 
                  width: settings.screenWidth, 
                  height: settings.screenHeight,
                  fit: BoxFit.contain,
                  errWidget: Container(color: Colors.black)
                )
            ),

            if (flag && widget.data != null && widget.data!.length > 1 && opacity == 1.0 && controller.hasClients)
              Positioned(
                top: settings.viewPadding.top + (settings.screenWidth / 50.0), 
                child:
                Container(
                  color: Colors.black54,
                  child:
                  Dots(
                    index: page,
                    count: widget.data!.length,
                    pageController: controller,
                    itemSize: settings.screenWidth / 25.0,
                    itemColor: Colors.white54,
                    itemColorSelected: Colors.white
                  )
                )
              ),

            if (flag)
              Positioned(
                bottom: settings.viewPadding.bottom,
                left: 0,
                child:
                Container(
                  color: Colors.black54,
                  child:
                  CupertinoButton(
                    onPressed: () => changeOpacity(0.0),
                    child:
                    Icon(CupertinoIcons.chevron_compact_left, 
                      color: Colors.white, 
                      size: settings.screenWidth / 8.0
                    )
                  )
                )
              )
          ])
        )
      )
    );
}