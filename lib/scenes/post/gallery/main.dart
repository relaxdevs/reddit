
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../states/settings.dart';

import '../../../elements/dots/main.dart';
import './listitem.dart';


class Gallery extends StatefulWidget {
  final List<String> arr;
  final Function? onPageChanged;
  final Function? onController;
  const Gallery(this.arr, {this.onPageChanged, this.onController, Key? key}): super(key: key);
  
@override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late PageController controller;
  int page = 0;

  void onPageChanged(int n) {
    page = n;
    if (mounted) setState((){});

    widget.onPageChanged?.call(n);
  }

  @override
  void initState() {
    controller = PageController();

    if (widget.onController != null)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onController?.call(controller);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = settings.screenWidth * 0.9;

    return Container(
      width: settings.screenWidth,
      height: size,
      child:
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
        Expanded(child: 
          PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
            itemCount: widget.arr.length,
            itemBuilder: (BuildContext context, int i) {
              String item = widget.arr[i];

              return GalleryItem(item, key: ValueKey('gallery-$item-$i'));
          })
        ),

        SizedBox(height: settings.screenWidth / 80.0),

        Dots(
          index: page, 
          count: widget.arr.length,
          pageController: controller,
          itemSize: settings.screenWidth / 25.0
        )
      ])
    );
  }
}
