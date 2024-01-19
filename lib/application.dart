
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './states/navigator.dart' as navigator;
import './states/settings.dart';

import './models/category.dart';

import './elements/animatedbutton.dart';
import './scenes/feed/main.dart';


Map<String, String> categories = {
  '🧑‍💻': 'FlutterDev',
  '💬': 'AskReddit',
  '👩‍🔬': 'Science',
  '🔥': 'Todayilearned',
  '🍿': 'Movies',
  '🔮': 'Random',
  '😂': 'Jokes',
  '😌': 'Aww',
  '🙀': 'Creepy',
  '🕹️': 'Gamedev',
  '🏝️': 'TravelHacks',
  '👽': 'Space',
  '✨': 'Showerthoughts',
  '🍔': 'Foodhacks',
  '🥳': 'GetMotivated'
};


class Application extends StatefulWidget {
  const Application({Key? key}): super(key: key);
  
@override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late List<CategoryModel> data;
  late CategoryModel item;
  ScrollController? controller;
  String randomKey = '';

  void changeItem(CategoryModel c) {
    if (c.link == 'Random') {
      randomKey = DateTime.now().millisecondsSinceEpoch.toString();
    } else if (item.link == c.link) {
      return;
    }

    item = c;
    controller = null;
    if (mounted) setState((){});
  }

  void onScrollController(ScrollController c) {
    controller = c;
    if (mounted) setState((){});
  }

  @override
  void initState() {
    data = categories.keys.map<CategoryModel>((k) => CategoryModel.fromJson({'emoji': k, 'link': categories[k]})).toList();
    item = data.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
      Stack(children: <Widget>[
        FeedList(
          key: ValueKey('app${item.link}' + randomKey),
          query: '/r/' + item.link,
          onScrollController: onScrollController,
          onPressed: (int index, Function getDataLength, Function getItem, Function getMoreData) => 
            navigator.showFeedItem(index, getDataLength, getItem, getMoreData, context: context)
        ),
        
        if (controller != null)
          AnimatedButton(
            key: ValueKey('app${item.link}-${item.emoji}'),
            right: settings.screenWidth / 50.0,
            bottom: settings.screenWidth / 50.0,
            controller: controller!,
            onPressed: () => navigator.showCategories(data, onPressed: changeItem, context: context),
            child:
            Text(item.emoji, style: TextStyle(
              fontSize: settings.screenWidth / 7.0
            ))
          )
      ])
    );
  }
}