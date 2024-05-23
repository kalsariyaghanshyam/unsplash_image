import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_img/app/constants/colors.dart';

Color color = appColors.xff000000;
// localUser.getBool('darkmode')! ? AppColor.secondary : AppColor.white;
Color rcolor =appColors.xff000000;
// !localUser.getBool('darkmode')! ? AppColor.secondary : AppColor.white;

appPrint(str){
  if (kDebugMode) {
    print(str);
  }
}