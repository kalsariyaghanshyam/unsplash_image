import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import '../../../constants/index.dart';
import '../../../model/index.dart';

class OnboardingController extends GetxController {
//==============================================================================
// ** Property **
//==============================================================================
  var current = 0.obs;
  final CarouselController carouselController = CarouselController();

  List<Onboarding> onboardingList = [
    Onboarding(
        image: AssetStrings.splash1, dec: 'Enjoy your \nLife with Image'),
    Onboarding(image: AssetStrings.splash2, dec: 'Greener with \nEvery Tap..'),
    Onboarding(image: AssetStrings.splash3, dec: 'Leaf by Leaf,\nGrow Smart.'),
  ].obs;

//==============================================================================
// ** GetX Life Cycle **
//==============================================================================
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
