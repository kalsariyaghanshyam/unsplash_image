import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

networkImage(String img,{double? height,BoxFit? fit}) {
  return CachedNetworkImage(
    placeholder: (context, url) =>
        const Center(child: CupertinoActivityIndicator()),
    imageUrl: img,
    fit: fit ?? BoxFit.cover,
    errorWidget: (context, url, error) =>
        const Center(child: CupertinoActivityIndicator()),
    width: Get.width,
    height: height,
  );
}
