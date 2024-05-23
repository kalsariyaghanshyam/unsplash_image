import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_img/app/constants/colors.dart';
import '../../../constants/index.dart';
import '../../../model/index.dart';
import '../../../reusable/index.dart';
import '../controllers/home_controller.dart';
import 'widget/card_view.dart';

class ImageDetails extends GetView<HomeController> {
  const ImageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hit data = Get.arguments;
    return Scaffold(
      backgroundColor: appColors.xffececee,
      appBar: appBarView(),
      body: CardView(
        imageUrl:
        data.largeImageUrl ?? emptyString,
        likeCount: "",
        totalView: "",
        title: "",
      ),
    );
  }

//==============================================================================
// ** Main widget **
//==============================================================================
  AppBar appBarView() {
    return AppBar(
      backgroundColor: appColors.xffececee,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FadeInRight(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.xff649676,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            Iconsax.shopping_cart,
            size: 27,
            color: rcolor,
          ),
        ),
      ],
    );
  }
}
