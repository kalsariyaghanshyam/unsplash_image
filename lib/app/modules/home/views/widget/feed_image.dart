import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:unsplash_img/app/constants/index.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';
import 'card_view.dart';
import 'package:unsplash_img/app/model/image_response_model.dart';

class FeedImageCart extends StatelessWidget {
  final HomeController controller;

  const FeedImageCart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isFalse) {
        return SmartRefresher(
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: () => controller.refreshData(),
          child: StaggeredGridView.countBuilder(
            staggeredTileBuilder: (int index) =>
                const StaggeredTile.count(1, 1.6),
            crossAxisCount: 2,
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            itemCount: controller.imgDataResponse.value.hits?.length,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            itemBuilder: (BuildContext context, int index) {
              var data = controller.imgDataResponse.value.hits?[index];

              String tagInput = data?.tags ?? emptyString;
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

              if (index % 2 == 0) {
                if (index == 0) {
                  return FadeInUp(
                    duration: const Duration(seconds: 1),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Transform.translate(
                          offset: const Offset(0.0, 100.0),
                          child: cardTile(data, tagValue),
                        ),
                        Transform.translate(
                          offset: const Offset(0.0, -100.0),
                          child: Text(
                            "${AppString.found}\n${controller.imgDataResponse.value.totalHits} ${AppString.results}",
                            style: prozaLibreText.get24.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return FadeInUp(
                  duration: const Duration(seconds: 1),
                  child: Transform.translate(
                    offset: const Offset(0.0, 110.0),
                    child: cardTile(data, tagValue),
                  ),
                );
              } else {
                return FadeInDown(
                  duration: const Duration(seconds: 1),
                  child: cardTile(data, tagValue),
                );
              }
            },
          ),
        );
      } else {
        return const Center(child: CupertinoActivityIndicator());
      }
    });
  }

//==============================================================================
// ** Helper widget **
//==============================================================================
  Widget cardTile(Hit? data, String tagValue) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Obx(() => CardView(
            imageUrl: data?.largeImageUrl ?? emptyString,
            likeCount: data?.likes.toString() ?? emptyString,
            totalView: data?.views.toString() ?? emptyString,
            title: tagValue,
            isLike: data?.isLiked.value ?? false,
            onTap: () {
              Get.toNamed(Routes.IMAGE_DETAILS,arguments: data);
            },
            likeOnTap: () {
              HapticFeedback.heavyImpact();
              data?.isLiked(true);
              Future<void>.delayed(const Duration(milliseconds: 2200))
                  .then((void value) {
                data?.isLiked(false);
              });
            },
          )),
    );
  }
}
