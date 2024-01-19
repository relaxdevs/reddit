
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/api/main.dart';

import '../../models/feeditem.dart';

import './listitem/main.dart';
import './listitem/wrap.dart';
import './nodata.dart';



class FeedList extends StatefulWidget {
  final String query;
  final EdgeInsets? padding;
  final Function? onPressed;
  final Function? onScrollController;
  const FeedList({required this.query, this.padding, this.onPressed, this.onScrollController, Key? key}): super(key: key);
  
@override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  ScrollController? controller;
  List<FeedItemModel>? data;
  Map<String, bool> objUsed = <String, bool>{};
  bool loading = true;

  void getApiData({String? page, Function? cb}) {
    loading = true;
    if (page != null && mounted) setState((){});

    api('feed', widget.query, page != null ? 'after=t3_$page' : '', (bool err, Map item) {
      if (err) {cb?.call(); return;}
      loading = false;
      if (page != null) objUsed[page] = true;

      if (data == null) data = <FeedItemModel>[];

      data?.addAll(item['data']['children']?.map<FeedItemModel>((item) => FeedItemModel.fromJson(item['data'])).toList());
      
      if (mounted) setState((){}); 
      
      cb?.call();
    });
  }

  bool getMoreData(int i, [Function? cb]) {
    if (i == data!.length - 1) {
      String id = data!.last.id;
      if (objUsed[id] == true) return false;

      getApiData(page: id, cb: cb);
      return true;
    } else {
      return false;
    }
  }
   


  @override
  void initState() {
    if (widget.onScrollController != null) {
      controller = ScrollController();
    
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onScrollController!(controller);
      });
    }

    getApiData();

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Container(
      child:
      ListView.builder(
        key: PageStorageKey('feedkey${widget.query}'),
        controller: controller,
        padding: widget.padding,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: (data?.length ?? 0) + (data?.isEmpty == true ? 1 : 0) + (loading ? 10 : 0),
        itemBuilder: (BuildContext context, int i) {
          if (data?.isEmpty == true) return NoDataInfo();
          if (data == null || i > (data!.length - 1)) return WrapItem();
          
          FeedItemModel item = data![i];

          return ListItem(item, key: ValueKey('${widget.query}-${item.id}-$i'),
            onPressed: () => widget.onPressed?.call(i, () => data!.length, (int i) => data![i], getMoreData),
            didMount: () => getMoreData(i)
          );
        }
      )
    );
}