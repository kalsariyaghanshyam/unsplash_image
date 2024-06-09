import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../constants/index.dart';
import '../../../model/index.dart';
import '../../../reusable/index.dart';
import '../controllers/home_controller.dart';

class ImageDetails extends GetView<HomeController> {
  const ImageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hit data = Get.arguments;
    return Scaffold(
        backgroundColor: appColors.xffececee,
        appBar: appBarView(),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.height * 0.04),
                child: FadeInLeft(
                  child: networkImage(
                    data.largeImageUrl ?? emptyString,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: FadeInUp(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Container(
              color: appColors.xff67864a,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.025, horizontal: Get.width * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FadeInUp(
                      child: Text(
                        capitalTag(data.tags),
                        textAlign: TextAlign.center,
                        style: prozaLibreText.get20.w700.xffFFFFFF,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          rowData(
                              title: data.likes.toString(),
                              icon: AssetStrings.likeIcn),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.06),
                            child: rowData(
                                title: data.comments.toString(),
                                icon: AssetStrings.comment),
                          ),
                          rowData(
                              title: data.views.toString(),
                              icon: AssetStrings.view),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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

  Row rowData({required String title, required String icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(icon,
            color: appColors.xffFFFFFF, height: Get.height * 0.03),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 2),
          child: FadeInDown(
            child: Text(
              title,
              style: prozaLibreText.get18.w700.xffFFFFFF.height01,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
