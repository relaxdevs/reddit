
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


Widget GreyContainer = Container(color: Colors.grey.shade100);


class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errWidget;
  const CachedImage(this.imageUrl, {required this.width, required this.height, this.fit, this.errWidget, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      width: width, 
      height: height, 
      child:
      imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!, 
            width: width, 
            height: height,
            fit: fit,
            color: Colors.white,
            colorBlendMode: BlendMode.dstOver,
            placeholder: (_, __) => errWidget ?? GreyContainer,
            errorWidget: (_, __, ___) => errWidget ?? GreyContainer
          )
        : errWidget ?? GreyContainer
    );
}