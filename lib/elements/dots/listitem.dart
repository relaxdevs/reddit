
import 'package:flutter/material.dart';


class ListItem extends StatelessWidget {
  final double size;
  final bool selected;
  final Color? color;
  final Color? colorSelected;
  const ListItem({required this.size, required this.selected, this.color, this.colorSelected, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child:
      Container(
        width: size * 0.55,
        height: size * 0.55,
        decoration: BoxDecoration(
          color: selected ? (colorSelected ?? Colors.black26) : (color ?? Colors.black12),   
          shape: BoxShape.circle
        )
      )
    );
}