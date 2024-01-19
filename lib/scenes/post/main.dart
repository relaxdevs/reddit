
import 'package:flutter/material.dart';

import '../../states/api/main.dart';
import '../../states/post.dart';
import '../../states/settings.dart';

import '../../models/feeditem.dart';
import '../../models/comment.dart';

import '../../elements/didmount.dart';
import '../feed_comments/listitem/main.dart';
import '../feed_comments/loading.dart';
import '../feed_comments/nodata.dart';
import './gallery/main.dart';
import './gallery/listitem.dart';
import './loading.dart';
import './userinfo.dart';
import './title.dart';
import './body.dart';
import './link.dart';


class PostInfo extends StatefulWidget {
  final FeedItemModel? item;
  final double? paddingTop;
  final String? itemLink;
  final Function? onScrollController;
  final Function? onUserPressed;
  final Function? onLinkPressed;
  final Function? onGalleryPressed;
  final void Function()? onCounterPressed;
  const PostInfo(this.item, {this.paddingTop, this.itemLink, this.onScrollController, this.onUserPressed, this.onLinkPressed, this.onGalleryPressed, this.onCounterPressed, Key? key}): super(key: key);
  
@override
  _PostInfoState createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  late ScrollController controller;
  late PostState state;
  int galleryPage = 0;
  PageController? galleryController;

  void onGalleryPageChanged(int n, {bool? fromMedia}) {
    galleryPage = n;

    if (fromMedia == true && galleryController?.hasClients == true) galleryController!.jumpToPage(n);
  }

  void onGalleryController(PageController c) {
    galleryController = c;
  }

  @override
  void initState() {
    controller = ScrollController();

    state = PostState(widget.item ?? FeedItemModel.fromJson({}), () => mounted ? setState((){}) : null);    

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.item != null) state.getUser();  

      widget.onScrollController?.call(controller);
    });

    if (widget.item == null && widget.itemLink != null) {
      api('post', widget.itemLink!, '', (bool err, Map item) {
        if (err) return;

        FeedItemModel? feedItem = item['data']?['children']?.isNotEmpty == true && item['data']?['children'][0]['data'] is Map
          ? FeedItemModel.fromJson(item['data']?['children'][0]['data'])
          : null;

        if (feedItem != null) {
          state = PostState(feedItem, () => mounted ? setState((){}) : null);    
          if (mounted) setState((){});
          state.getUser(); 
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double padding = settings.screenWidth / 23.0;

    return Container(
      color: Colors.white,
      child: 
      ListView.builder(
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: EdgeInsets.only(
          top: widget.paddingTop ?? settings.screenWidth / 15.0,
          bottom: settings.screenWidth / 3.0,
        ),
        itemCount: state.item.id == '' ? 1 : (state.offset + (state.data?.length ?? 0) + (state.data?.isEmpty == true ? 1 : 0) + (state.loading ? 10 : 0)),
        itemBuilder: (BuildContext context, int i) {
          if (state.item.id == '') return LoadingItem();
          
          if (i < state.offset) return Padding(
            padding: EdgeInsets.only(
              bottom: i == 0 
                ? settings.screenWidth / 15.0
                : settings.screenWidth / 30.0,
              left: (i == 3 || i == 4 && state.isLinkFromReddit) ? 0 : padding,
              right: (i == 3 || i == 4 && state.isLinkFromReddit) ? 0 : padding,
            ), 
            child: 
            GestureDetector(
              onTap: !(i == 3 || (i == 4 && state.isLinkFromReddit)) || widget.onGalleryPressed == null 
                ? null 
                : () => widget.onGalleryPressed!(
                    index: galleryPage, 
                    link: state.isLinkFromReddit ? state.item.link : state.item.thumbnail, 
                    data: state.item.gallery,
                    onPageChanged: (int n) => onGalleryPageChanged(n, fromMedia: true)
                  ),
              child:
              i == 0 ? UserCountersInfo(state.item, 
                onUserPressed: widget.onUserPressed != null 
                  ? () => widget.onUserPressed!(state.item.author)
                  : null
                )

              : i == 1 ? TitleItem(state.item.title)

              : i == 2 ? state.item.selftext.isNotEmpty ? BodyItem(state.item.selftext) : SizedBox()
              
              : i == 3 
                  ? state.item.gallery.isNotEmpty ? Gallery(state.item.gallery, onController: onGalleryController, onPageChanged: onGalleryPageChanged)
                  : state.item.thumbnail.isNotEmpty 
                      ? !state.isLinkFromReddit 
                          ? GalleryItem(state.item.thumbnail)
                          : SizedBox()
                  : SizedBox()

              : state.isLinkFromReddit
                  ? GalleryItem(state.item.link)
                  : Align(alignment: Alignment.centerLeft,child: LinkItem(state.item.link, 
                      onPressed: widget.onLinkPressed != null ? () => widget.onLinkPressed!(state.item.link) : null
                    ))
            )
          );


          if (state.data?.isEmpty == true) return CommentNoData;


          if (state.data == null || (i - state.offset) > (state.data!.length - 1)) {
            return (i - state.offset) == 0
              ? DidMountWidget(
                  didMount: state.getComments,
                  child: CommentLoading
                )
              : CommentLoading;
          }
          

          CommentModel item = state.data![i - state.offset];
            
          return Padding(
            padding: EdgeInsets.only(
              left: padding + ((item.depth > 0) ? (settings.screenWidth / 20.0) : 0),
              right: padding
            ),
            child:
            CommentListItem(item, 
              key: ValueKey('comment${item.id}'),
              onUserPressed: widget.onUserPressed != null 
                ? () => widget.onUserPressed!(item.author)
                : null,
              onCounterPressed: widget.onCounterPressed,
              onShowRepliesPressed: (item.replies.isNotEmpty && state.objUsed[item.id] != true) 
                ? () => state.showReplies(item, i)
                : null,
              didMount: (i - state.offset) != state.data!.length - 1 ? null : state.checkMoreComments
            )
          );   
        }
      )
    );
  }
}