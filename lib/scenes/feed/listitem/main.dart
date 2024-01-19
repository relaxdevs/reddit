
import 'package:flutter/cupertino.dart';

import '../../../states/settings.dart';

import '../../../models/feeditem.dart';

import '../../../elements/counter.dart';
import './wrap.dart';
import './title.dart';
import './body.dart';


class ListItem extends StatefulWidget {
  final FeedItemModel item;
  final void Function()? onPressed;
  final Function? didMount;
  const ListItem(this.item, {this.onPressed, this.didMount, Key? key}): super(key: key);
  
@override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    if (widget.didMount != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.didMount?.call();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: widget.onPressed,
      child:
      Container(
        margin: EdgeInsets.symmetric(
          vertical: settings.screenWidth / 130.0
        ), 
        child:
        Stack(children: <Widget>[
          WrapItem(child:
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: settings.screenWidth / 20.0,
                  bottom: widget.item.selftext.isNotEmpty ? settings.screenWidth / 30.0 : 0
                ),
                child:
                TitleItem(widget.item.title)
              ),

              if (widget.item.selftext.isNotEmpty)
                BodyItem(widget.item.selftext)
            ])
          ),

          if (widget.item.score != 0 || widget.item.countComments > 0)
          Positioned(
            top: 0, 
            right: settings.screenWidth / 60.0, 
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
              if (widget.item.score != 0)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: settings.screenWidth / 100.0
                  ),
                  child:
                  CircleCounter(widget.item.score, showPlus: true)
                ),

              if (widget.item.countComments > 0)
                CircleCounter(widget.item.countComments)
            ])
          )
        ])
      )
    );
}