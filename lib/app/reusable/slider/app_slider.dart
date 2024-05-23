import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/index.dart';

class AppSlider extends StatelessWidget {
  final CarouselController carouselController;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;
  final List<Widget> items;
  final int currentIndex;
  final int itemLength;

  const AppSlider({super.key,
    required this.carouselController,
    required this.onPageChanged,
    required this.items,
    required this.currentIndex,
    required this.itemLength});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
              aspectRatio: Get.width / Get.height,
              onPageChanged: onPageChanged),
          items: items,
        ),
        dotIndicator()
      ],
    );
  }

//==============================================================================
// ** Helper widget **
//==============================================================================
  Align dotIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemLength, (index) {
          if (itemLength <= 1) {
            return const SizedBox.shrink();
          } else {
            return Container(
              width: Get.width * 0.02,
              height: Get.width * 0.02,
              margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.022,
                horizontal: Get.width * 0.01,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appColors.xff000000,
                ),
                borderRadius: BorderRadius.circular(50),
                color: index == currentIndex
                    ? appColors.xff000000
                    : appColors.xffD9D9D9,
              ),
            );
          }
        }),
      ),
    );
  }
}
