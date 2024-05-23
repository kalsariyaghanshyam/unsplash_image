import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/index.dart';
import '../../../reusable/slider/app_slider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';
import 'widget/bottom_navigation_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
//==============================================================================
// ** Property **
//==============================================================================
  late AnimationController aniController;

//==============================================================================
// ** Life cycle **
//==============================================================================
  @override
  void initState() {
    super.initState();
    aniController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OnboardingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: appColors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offAndToNamed(Routes.HOME);
                },
                child: Text(
                  AppString.skip,
                  style: prozaLibreText.get14,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Obx(() => BottomNavigationButton(
                current: controller.current.value,
                controller: aniController,
                carouselController: controller.carouselController,
              )),
          body: Obx(() => sliderView(controller)),
        );
      },
    );
  }

  @override
  void dispose() {
    aniController.dispose();
    super.dispose();
  }

//==============================================================================
// ** Main widget **
//==============================================================================
  Widget sliderView(OnboardingController controller) {
    return AppSlider(
      carouselController: controller.carouselController,
      onPageChanged: (int index, CarouselPageChangedReason reason) {
        controller.current.value = index;
      },
      items: controller.onboardingList.map((e) {
        return Column(
          children: [
            SizedBox(
              height: Get.height / 1.7,
              width: Get.width / 1.2,
              child: FadeIn(
                duration: const Duration(seconds: 1),
                child: Lottie.asset(
                  e.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeInUp(
                child: FadeInLeft(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: formatSentence(e.dec),
                            style: normalText.get40.xff000000.w300.height0102),
                        TextSpan(
                          text: e.dec.split(' ').last,
                          style: prozaLibreText.get40.xff000000.w500.height0102,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }).toList(),
      currentIndex: controller.current.value,
      itemLength: controller.onboardingList.length,
    );
  }

//==============================================================================
// ** Helper widget **
//==============================================================================
  String formatSentence(String text) {
    return '${text.toString().split(' ').sublist(0, text.split(' ').length - 1).join(' ')} ';
  }
}
