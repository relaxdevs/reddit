
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../states/settings.dart';

import './listitem.dart';


class Dots extends StatefulWidget {
  final int index;
  final int count;
  final double itemSize;
  final Color? itemColor;
  final Color? itemColorSelected;
  final PageController pageController;
  const Dots({required this.index, required this.count, required this.itemSize, this.itemColor, this.itemColorSelected, required this.pageController, Key? key}): super(key: key);
  
@override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  late ScrollController controller;

  @override
  void initState() {
    double n = widget.index - 2.0;
    double offset = (n * widget.itemSize).clamp(0.0, max(0.0, (widget.count - 5.0) * widget.itemSize));

    controller = ScrollController(initialScrollOffset: offset);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.pageController.addListener(() {
        if (controller.hasClients == true) {
          double n = (widget.pageController.offset / settings.screenWidth) - 2.0;
          double offset = (n * widget.itemSize).clamp(0.0, controller.position.maxScrollExtent);
          
          controller.jumpTo(offset);
        }
      });
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
      width: widget.itemSize * min(5, widget.count),
      height: widget.itemSize,
      child:
      ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.count,
        itemBuilder: (BuildContext context, int i) =>
          ListItem(
            selected: i == widget.index, 
            size: widget.itemSize,
            color: widget.itemColor,
            colorSelected: widget.itemColorSelected
          )
      )
    );
}