import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:unsplash_img/app/model/local_model.dart';
import '../../../../constants/index.dart';
import '../../controllers/home_controller.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Drawer(
            width: Get.width * 0.68,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.04),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.center,
                          style: latoText.get24.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            manageBoolValue();
                            controller.getImageData(
                                page: 1,
                                category: emptyString,
                                imageType: emptyString,
                                orientation: emptyString);
                          },
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Clear all",
                                style: latoText.get15.w600
                                    .textColor(appColors.xff091a6b)
                                    .underLine,
                              )),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.03, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orientation",
                          textAlign: TextAlign.center,
                          style: latoText.get18.w600,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.05),
                          child: Row(
                            children: List.generate(
                                controller.orientationList.length, (index) {
                              var res = controller.orientationList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    manageBoolValue();
                                    res.isClick.value = true;
                                    controller.getImageData(
                                        page: 1, orientation: res.title);
                                  },
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: res.isClick.isTrue
                                                  ? appColors.xff006685
                                                  .withOpacity(0.2)
                                                  : appColors.trans),
                                          color: res.isClick.isTrue
                                              ? appColors.xff006685
                                              .withOpacity(0.08)
                                              : appColors.trans,
                                          borderRadius:
                                          BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(res.img,
                                            height: Get.height * 0.035,
                                            color: appColors.xff000000),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(res.title.capitalize.toString(),
                                          style: prozaLibreText
                                              .size(
                                              res.isClick.isTrue ? 15.5 : 15)
                                              .weight(res.isClick.isTrue
                                              ? FontWeight.w600
                                              : FontWeight.w500)
                                              .textColor(
                                            appColors.xff000000
                                                .withOpacity(0.65),
                                          )),
                                    )
                                  ]),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      color: appColors.xff000000.withOpacity(0.4), height: 20),
                  filterList()
                ],
              ),
            ),
          )),
    );
  }

  void manageBoolValue() {
    for (var item in controller.orientationList) {
      item.isClick.value = false;
    }

    for (var item in controller.drawerItem) {
      for (var child in item.filterChild) {
        child.isClick.value = false;
      }
    }
  }

//==============================================================================
// ** Helper widget **
//==============================================================================
  Widget filterList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(left: Get.width * 0.005),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.drawerItem.length,
        itemBuilder: (context, index) {
          var data = controller.drawerItem[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: 5, top: index == 0 ? 0 : 8, left: 10),
                child: Text(data.title, style: latoText.get18.w600),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.filterChild.length,
                itemBuilder: (context, index) {
                  var res = data.filterChild[index];
                  return filterChildTile(index, data, res);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget filterChildTile(int index, FilterList data, FilterChild res) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: index == 0 ? 0 : 1),
      child: GestureDetector(
          onTap: () {
            String imageType = emptyString;
            String category = emptyString;
            if (data.title == AppString.imageType) {
              imageType = res.text;
            } else if (data.title == AppString.category) {
              category = res.text;
            }
            Get.back();
            for (var item in controller.drawerItem) {
              for (var child in item.filterChild) {
                child.isClick.value = false;
              }
            }
            for (var item in controller.orientationList) {
              item.isClick.value = false;
            }

            res.isClick.value = true;
            controller.getImageData(
                page: 1, category: category, imageType: imageType);
          },
          child: Container(
            decoration: BoxDecoration(
                border: res.isClick.isTrue
                    ? Border(
                    top: borderSide(),
                    bottom: borderSide(),
                    right: borderSide())
                    : null,
                color: res.isClick.isTrue
                    ? appColors.xff006685.withOpacity(0.08)
                    : appColors.trans,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (res.isClick.isTrue)
                    Container(
                      color: Colors.red,
                      height: 25,
                      width: 3,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 30),
                    child: Text(
                      res.text.capitalize.toString(),
                      style: prozaLibreText.size(15.5)
                          .weight(res.isClick.isTrue
                          ? FontWeight.w600
                          : FontWeight.w500)
                          .textColor(appColors.xff000000.withOpacity(0.65)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  BorderSide borderSide() {
    return BorderSide(color: appColors.xff006685.withOpacity(0.2), width: 0.5);
  }
}
