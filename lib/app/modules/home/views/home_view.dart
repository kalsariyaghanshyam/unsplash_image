import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_img/app/constants/index.dart';
import 'package:unsplash_img/app/modules/home/views/widget/feed_image.dart';
import '../../../reusable/index.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.focus.unfocus();
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: appColors.xffececee,
        appBar: appBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: appColors.trans,
                leading: const SizedBox.shrink(),
                expandedHeight: 100.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    stretchModes: const <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    centerTitle: false,
                    expandedTitleScale: 1.1,
                    background: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: Get.width / 1.4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: appColors.xffFFFFFF,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: AppTextField(
                              controller: controller.searchController,
                              focusNode: controller.focus,
                              placeholder: "Search image",
                              suffixOnTap: () {
                                controller.focus.unfocus();
                                controller.searchController.clear();
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: /*!localUser.getBool('darkmode')!
                                      ? Colors.white
                                      :*/
                                      appColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  Icons.display_settings_rounded,
                                  color: rcolor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ];
          },
          body: FeedImageCart(controller: controller),
        ),
      ),
    );
  }

//==============================================================================
// ** Main widget **
//==============================================================================
  AppBar appBar() {
    return AppBar(
      backgroundColor: appColors.xffececee,
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 8, bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                  height: 40,
                  "https://images.unsplash.com/photo-1715412406617-e76cd73e644d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4NHx8fGVufDB8fHx8fA%3D%3D"),
            ),
          ),
        ),
      ],
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 100,
            color: Colors.black.withOpacity(0),
            width: Get.width / 1,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppString.appName,
        style: prozaLibreText.get22.w500,
      ),
    );
  }
}
