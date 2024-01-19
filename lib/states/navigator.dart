
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './localization.dart';
import './settings.dart';

import '../models/category.dart';
import '../models/user.dart';

import '../scenes/modal/main.dart';
import '../scenes/pagewrap/main.dart';
import '../scenes/categories/main.dart';
import '../scenes/feed/main.dart';
import '../scenes/feed/userinfo.dart';
import '../scenes/feed_comments/main.dart';
import '../scenes/post/main.dart';
import '../scenes/gallery/main.dart';
import '../scenes/popup/main.dart';
import '../scenes/weblink/main.dart';
import '../scenes/route.dart';
import '../elements/avatar.dart';


void navigatorPush(BuildContext context, {double? middleControllerValue, bool? showBackButton, bool? closeOnBackButtonPressed, Widget? topLeftChild, Widget? child, Function? builder}) {
  Navigator.push(context, NoAnimationCupertinoRoute(builder: (BuildContext context) => 
    ModalWrap(
      middleControllerValue: middleControllerValue,
      showBackButton: showBackButton,
      closeOnBackButtonPressed: closeOnBackButtonPressed,
      onScrollEnd: () => showPopup(title: localization('Latest'), context: context),
      onBackPressed: () => Navigator.pop(context),
      topLeftChild: topLeftChild,
      builder: builder,
      child: child
    )
  ));
}

void showFeedItem(int index, Function getDataLength, Function getItem, Function getMoreData, {Function? getItemLink, required BuildContext context}) =>
  navigatorPush(context, builder: (BuildContext context, bool mode, Function onScrollController, Function animateController) =>
    PageViewWrap(
      index: index,
      getItemCount: getDataLength,
      showDots: mode != true,
      onPageChanged: getMoreData,
      builder: (int i) => 
        PostInfo(getItem(i), 
          paddingTop: mode ? (settings.viewPadding.top + settings.screenWidth / 20.0) : null,
          itemLink: getItemLink?.call(i),
          onScrollController: onScrollController,
          onUserPressed: (UserModel item) => item.banned
              ? showPopup(title: localization('Suspended'), context: context)
              : showFeedUser(item, context: context),
          onCounterPressed: () => showPopup(title: localization('Karma'), context: context),
          onLinkPressed: (String s) => showLinkConfirm(s, context: context),
          onGalleryPressed: ({int? index, String? link, List<String>? data, Function? onPageChanged}) => showGallery(index: index, link: link, data: data, onPageChanged: onPageChanged, context: context)
      ) 
    )
  );

void showFeedUser(UserModel userItem, {required BuildContext context}) {
  navigatorPush(context, 
    middleControllerValue: 0.8, 
    closeOnBackButtonPressed: true, 
    topLeftChild: UserAvatar(userItem.avatar),
    builder: (BuildContext context, bool mode, Function onScrollController, Function animateController) =>
      PageViewWrap(
        index: 0,
        itemCount: 2,
        headerWidget: UserInfo(userItem,
          padding: EdgeInsets.only(top: mode ? (settings.viewPadding.top + settings.screenWidth / 20.0) : 0),
          onUserPressed: () => showGallery(link: userItem.avatar, context: context)
        ),
        onPageChanged: (int i, [_]) => showPopup(title: localization(i == 0 ? 'Feed' : 'Comments'), context: context),
        builder: (int i) => i == 0 
          ? FeedList(
              key: ValueKey('user${userItem.name}'),
              query: 'user/${userItem.name}/submitted',
              padding: EdgeInsets.all(0),
              onPressed: (int index, Function getDataLength, Function getItem, Function getMoreData) => showFeedItem(index, getDataLength, getItem, getMoreData, context: context)
            )
          : FeedListComments(userItem,
              onUserPressed: (int index, Function getDataLength, Function getItem, Function getMoreData, Function getItemLink) => showFeedItem(index, getDataLength, getItem, getMoreData, getItemLink: getItemLink, context: context),
              onCounterPressed: () => showPopup(title: localization('Karma'), context: context)
            )
      )
  );
}

void showCategories(List<CategoryModel> data, {required Function onPressed, required BuildContext context}) =>
  navigatorPush(context, middleControllerValue: 1.0, showBackButton: false, child: 
    CategoriesList(data,
      onPressed: (CategoryModel item) {
        onPressed(item);
        Navigator.pop(context);
        showPopup(title: item.link, context: context);
      }
    )
  );

void showLinkConfirm(String value, {required BuildContext context}) =>
  navigatorPush(context, middleControllerValue: 1.0, showBackButton: false, 
    builder: (BuildContext context, bool mode, Function onScrollController, Function animateController) =>
      WebLinkConfirm(value, 
        onBackPressed: () => animateController(0.0)
      )
  );

void showGallery({int? index, String? link, List<String>? data, Function? onPageChanged, required BuildContext context}) =>
  Navigator.push(context, NoAnimationCupertinoRoute(builder: (BuildContext context) =>
    MediaGallery(
      index: index,
      link: link,
      data: data,
      onPageChanged: onPageChanged,
      onBackPressed: () => Navigator.pop(context)
    )
));

void showPopup({String? title, required BuildContext context}) =>
  Navigator.push(context, NoAnimationCupertinoRoute(builder: (BuildContext context) =>
    PopupInfo(
      title: title,
      onBackPressed: () => Navigator.pop(context)
    )
  ));