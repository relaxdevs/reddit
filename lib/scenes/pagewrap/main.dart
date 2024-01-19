
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/settings.dart';

import '../post/loading.dart';
import '../../elements/dots/main.dart';


class PageViewWrap extends StatefulWidget {
  final int index;
  final int? itemCount;
  final Function? getItemCount;
  final bool? showDots;
  final Function builder;
  final Function? onPageChanged;
  final Widget? headerWidget;
  const PageViewWrap({required this.index, this.itemCount, this.getItemCount, this.showDots, required this.builder, this.onPageChanged, this.headerWidget, Key? key}): super(key: key);
  
@override
  _PageViewWrapState createState() => _PageViewWrapState();
}

class _PageViewWrapState extends State<PageViewWrap> {
  ScrollController? dotsController;
  late PageController controller;
  late int page;
  late int itemCount;
  double size = 100.0;
  double offset = 0.0;
  bool loading = false;
  Map<int, bool> objUsed = <int, bool>{};

  void onPageChanged(int n) {
    page = n;
    if (mounted) setState((){});

    if (objUsed[n] == true) return;
    
    loading = widget.onPageChanged?.call(n, () {  
      itemCount = widget.getItemCount?.call() ?? widget.itemCount ?? 0;

      loading = false;
      if (mounted) setState((){});
    }) == true;
    
    if (loading) {
      objUsed[n] = true;
      if (mounted) setState((){});
    }
  }

  @override
  void initState() {
    page = widget.index;
    controller = PageController(initialPage: page);

    itemCount = widget.getItemCount?.call() ?? widget.itemCount ?? 0;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        if (widget.headerWidget != null)
          SliverToBoxAdapter(
            child: widget.headerWidget
          ),

        if (itemCount > 1 && widget.showDots != false)
          SliverToBoxAdapter(child: 
            Container(alignment: Alignment.center, child: 
              Dots(
                index: page, 
                count: itemCount,
                pageController: controller,
                itemSize: settings.screenWidth / 25.0
              )
            )
          ),
      ],
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        physics: widget.showDots != false 
          ? AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()) 
          : NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemCount: itemCount + (loading ? 1 : 0),
        itemBuilder: (BuildContext context, int i) => i >= itemCount
          ? LoadingItem()
          : widget.builder(i)
      )
    );
}