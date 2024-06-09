import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constants/index.dart';

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

String capitalTag(tag){
  String tagInput = tag ?? emptyString;
  List<String> words = tagInput.split(', ');

  List<String> capitalizedWords = words.map((word) {
    String trimmedWord = word.trim();
    if (trimmedWord.isNotEmpty) {
      return trimmedWord[0].toUpperCase() +
          trimmedWord.substring(1).toLowerCase();
    } else {
      return '';
    }
  }).toList();

  String tagValue = capitalizedWords.join(', ');

  return tagValue;
}
