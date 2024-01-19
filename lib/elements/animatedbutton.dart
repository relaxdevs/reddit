
import 'package:flutter/cupertino.dart';


class AnimatedButton extends StatefulWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final ScrollController controller;
  final void Function()? onPressed;
  final Widget child;
  const AnimatedButton({this.top, this.bottom, this.left, this.right, required this.controller, this.onPressed, required this.child, Key? key}): super(key: key);
  
@override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150))
      ..addListener(() => mounted ? setState((){}) : null);

    widget.controller.position.isScrollingNotifier.addListener(() { 
      if(widget.controller.position.isScrollingNotifier.value) {
        controller.animateTo(1.0, curve: Curves.easeInOut);
      } else {
        controller.reverse();
      }
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
    Positioned(
      top: widget.top,
      bottom: widget.bottom,
      left: widget.left,
      right: widget.right,
      child:
      Transform.translate(
        offset: Offset(0, controller.value * 50.0),
        child:
        CupertinoButton(
          onPressed: widget.onPressed,
          child: widget.child
        )
      )
    );
}