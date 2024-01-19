
import 'package:flutter/cupertino.dart';

import '../states/settings.dart';

import './cachedimage.dart';


class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final BoxFit? fit;
  final void Function()? onPressed;
  const UserAvatar(this.imageUrl, {this.size, this.fit, this.onPressed, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = this.size ?? settings.screenWidth / 5.0;

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: onPressed,
      child:
      CachedImage(imageUrl, 
        width: size, 
        height: size,
        fit: fit
      )
    );
  }
}