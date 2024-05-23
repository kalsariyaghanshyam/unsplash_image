import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:unsplash_img/app/reusable/app_button/app_button.dart';
import '../../../../constants/index.dart';
import '../../../../routes/app_pages.dart';

class BottomNavigationButton extends StatelessWidget {
  final int current;
  final CarouselController carouselController;
  final AnimationController controller;

  const BottomNavigationButton({
    super.key,
    required this.current,
    required this.carouselController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          if (current == 2) {
            return ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.0).animate(
                CurvedAnimation(
                  curve: Curves.linear,
                  parent: controller,
                ),
              ),
              child: RotationTransition(
                turns: Tween<double>(begin: 0.0, end:1).animate(
                  CurvedAnimation(
                    curve: Curves.linear,
                    parent: controller,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
                  child: AppButton(text: AppString.letsStart, onTap: () {
                    Get.offAndToNamed(Routes.HOME);
                      }),
                ),
              ),
            );
          } else {
            return bottomAction(context);
          }
        },
        child: bottomAction(context),
      ),
    );
  }

//==============================================================================
// ** Helper Widget **
//==============================================================================
  Widget bottomAction(BuildContext context) {
    return Hero(
      tag: 'back',
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          carouselController.jumpToPage(current + 1);
          controller.forward(from: 0.0);
        },
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.1).animate(
            CurvedAnimation(
              curve: Curves.easeOut,
              parent: controller,
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                curve: Curves.easeOut,
                parent: controller,
              ),
            ),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.xff34B233,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
