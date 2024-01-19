
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DidMountWidget extends StatefulWidget {
  final Widget? child;
  final Function didMount;
  const DidMountWidget({this.child, required this.didMount, Key? key}): super(key: key);
  
@override
  _DidMountWidgetState createState() => _DidMountWidgetState();
}

class _DidMountWidgetState extends State<DidMountWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.didMount();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    widget.child ?? SizedBox();
}