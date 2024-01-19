
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../states/settings.dart';

import '../../models/category.dart';


class CategoriesList extends StatelessWidget {
  final List<CategoryModel> data;
  final Function onPressed;
  const CategoriesList(this.data, {required this.onPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      color: Colors.white,
      height: settings.screenHeight * 0.4,
      width: settings.screenWidth,
      child:
      GridView.builder(
        key: PageStorageKey('categories'),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5
        ),
        padding: EdgeInsets.only(
          top: settings.screenWidth / 15.0,
          bottom: settings.screenWidth / 5.0
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          CategoryModel item = data[i];

          return CupertinoButton(
            onPressed: () => onPressed(item),
            child:
            Text(item.emoji, style: TextStyle(
              fontSize: settings.screenWidth / 8.0
            ))
          );
        }  
      )
    );
}