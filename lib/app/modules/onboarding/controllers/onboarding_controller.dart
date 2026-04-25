import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../constants/index.dart';
import '../../../model/index.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
//==============================================================================
// ** Property **
//==============================================================================
  var current = 0.obs;
  final CarouselSliderController carouselController = CarouselSliderController();
  final storage = GetStorage();

  List<Onboarding> onboardingList = [
    Onboarding(
        image: AssetStrings.splash1, dec: 'Enjoy your \nLife with Image'),
    Onboarding(image: AssetStrings.splash2, dec: 'Greener with \nEvery Tap..'),
    Onboarding(image: AssetStrings.splash3, dec: 'Leaf by Leaf,\nGrow Smart.'),
  ].obs;

  void completeOnboarding() {
    storage.write('isFirstTime', false);
    Get.offAllNamed(Routes.HOME);
  }

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
