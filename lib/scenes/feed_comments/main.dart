
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/api/main.dart';
import '../../states/settings.dart';

import '../../models/comment.dart';
import '../../models/user.dart';

import './listitem/main.dart';
import './loading.dart';
import './nodata.dart';


class FeedListComments extends StatefulWidget {
  final UserModel item;
  final void Function()? onCounterPressed;
  final Function? onUserPressed;
  const FeedListComments(this.item, {this.onCounterPressed, this.onUserPressed, Key? key}): super(key: key);
  
@override
  _FeedListCommentsState createState() => _FeedListCommentsState();
}

class _FeedListCommentsState extends State<FeedListComments> {
  List<CommentModel>? data;
  Map<String, bool> objUsed = <String, bool>{};
  bool loading = true;


  void getComments({String? page, Function? cb}) {
    loading = true;
    if (page != null && mounted) setState((){});

    api('user_comments', widget.item.name, page != null ? 'after=t1_$page' : '', (bool err, Map item) {
      if (err) return;
      loading = false;

      if (data == null) data = <CommentModel>[];

      List<CommentModel>? arr = item['data']?['children']?.map<CommentModel>((json) {
        CommentModel item = CommentModel.fromJson(json['data']);
        item.author = widget.item;
        return item;
      })?.toList();

      if (arr != null) data?.addAll(arr);

      if (mounted) setState((){});

      cb?.call();
    });
  }

  bool getMoreData(int i, [Function? cb]) {
    if (i == data!.length - 1) {
      String id = data!.last.id;
      if (objUsed[id] == true) return false;

      getComments(page: id, cb: cb);
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getComments();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    ListView.builder(
      key: PageStorageKey('feed_commentskey${widget.item.name}'),
      padding: EdgeInsets.only(
        bottom: settings.screenWidth / 3.0
      ),
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: (data?.length ?? 0) + (data?.isEmpty == true ? 1 : 0) + (loading ? 10 : 0),
      itemBuilder: (BuildContext context, int i) {
        if (data == null || (data!.isNotEmpty && (i > (data!.length - 1)))) return CommentLoading;
        if (data?.isEmpty == true) return CommentNoData;
        
        CommentModel item = data![i];

        return CommentListItem(item, 
          key: ValueKey('comment${widget.item.name}-${item.id}-$i'),
          onCounterPressed: widget.onCounterPressed,
          onUserPressed: widget.onUserPressed != null 
            ? () => widget.onUserPressed!(i, () => data!.length, (int i) => null, getMoreData, (int i) => data![i].parent)
            : null,
          didMount: i != data!.length - 1 ? null : () => getMoreData(i)
        );
      }
    );
}