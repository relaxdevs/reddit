
import 'package:flutter/material.dart';

import '../../../states/settings.dart';

import '../../../elements/cachedimage.dart';


class GalleryItem extends StatelessWidget {
  final String value;
  const GalleryItem(this.value, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    CachedImage(value,
      width: settings.screenWidth,
      height: settings.screenWidth,
      fit: BoxFit.cover
    );
}