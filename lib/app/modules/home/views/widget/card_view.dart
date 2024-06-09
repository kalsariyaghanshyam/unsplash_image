import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/index.dart';
import '../../../../reusable/index.dart';

class CardView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String totalView;
  final String likeCount;
  final void Function()? likeOnTap;
  final void Function()? onTap;
  bool isLike;

  CardView(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.totalView,
      required this.likeCount,
      this.isLike = false,
      this.likeOnTap,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: onTap != null ? appColors.xffFFFFFF : appColors.trans,
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: imageUrl,
                    child: networkImage(
                      imageUrl,

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          title,
                          style: prozaLibreText.get15.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   totalView,
                          //   style: TextStyle(
                          //     color: rcolor,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 16,
                          //   ),
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: likeOnTap,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      isLike == true
                                          ? Iconsax.heart5
                                          : Iconsax.heart_add,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                likeCount,
                                style: TextStyle(
                                  color: rcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLike)
          LottieBuilder.asset(
            AssetStrings.like,
            fit: BoxFit.cover,
          )
      ]),
    );
  }

  Widget rowText(
      {required String title,
      required String dec,
      IconData? icon,
      void Function()? onTapLike}) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: onTapLike,
              child: Icon(
                icon,
                color: appColors.xffF44336,
              ),
            ),
          ),
        RichText(
          text: TextSpan(
            text: title,
            style: latoText.get15.w500,
            children: <TextSpan>[
              TextSpan(
                  text: dec,
                  style: latoText.get15.w600
                      .textColor(appColors.xff000000.withOpacity(0.7))),
            ],
          ),
        ),
      ],
    );
  }
}
