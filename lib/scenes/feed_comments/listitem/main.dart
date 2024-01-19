
import 'package:flutter/material.dart';

import '../../../states/api/main.dart';
import '../../../states/settings.dart';

import '../../../models/comment.dart';
import '../../../models/user.dart';

import '../../../elements/counter.dart';
import '../../../elements/avatar.dart';
import '../nodata.dart';
import './name.dart';
import './body.dart';
import './repliesbutton.dart';


class CommentListItem extends StatefulWidget {
  final CommentModel item;
  final void Function()? onShowRepliesPressed;
  final void Function()? onCounterPressed;
  final void Function()? onUserPressed;
  final Function? didMount;
  const CommentListItem(this.item, {this.onShowRepliesPressed, this.onCounterPressed, this.onUserPressed, this.didMount, Key? key}): super(key: key);
  
@override
  _CommentListItemState createState() => _CommentListItemState();
}

class _CommentListItemState extends State<CommentListItem> {
  late bool deleted;
  bool flag = false;

  @override
  void initState() {
    deleted = (widget.item.author.name.isEmpty) || isDeleted(widget.item.author.name) && isDeleted(widget.item.body);
    
    if (!deleted && !isDeleted(widget.item.author.name) && widget.item.author.avatar?.isNotEmpty != true) {
      api('user', widget.item.author.name, '', (bool err, Map item) {
        if (err) return;
        
        widget.item.author = UserModel.fromJson(item['data']);
        if (mounted) setState((){});
      });
    } 

    if (widget.didMount != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.didMount?.call();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double avatarSize = settings.screenWidth / 6.5;
    double offset = avatarSize / 2.0;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: settings.screenWidth / 20.0,
        horizontal: settings.screenWidth / 23.0,
      ),
      child: deleted 
        ? Center(child: DeletedComment())
        
        : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
              UserAvatar(widget.item.author.avatar, 
                size: avatarSize,
                onPressed: widget.onUserPressed
              ), 

              if (widget.item.score > 0)
                Container(
                  color: Colors.white, 
                  alignment: Alignment.centerLeft, 
                  margin: EdgeInsets.only(left: offset / 3.0),
                  child:
                  Counter(widget.item.score, onPressed: widget.onCounterPressed)
                ),
            ]),

            NameItem(widget.item.author.name),

            GestureDetector(
              onTap: flag ? null : () {
                flag = !flag;
                if (mounted) setState((){});
              },
              child:
              BodyItem(widget.item.body, maxLines: flag ? null : 10) 
            ),

          if (widget.onShowRepliesPressed != null)
            RepliesButton(widget.item.replies.length, onPressed: widget.onShowRepliesPressed)
      ])
    );
  }
}