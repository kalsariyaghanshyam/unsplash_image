import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/image_details.dart';
import '../modules/myApp/bindings/my_app_binding.dart';
import '../modules/myApp/views/my_app_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final storage = GetStorage();
  static String get INITIAL {
    bool isFirstTime = storage.read('isFirstTime') ?? true;
    return isFirstTime ? Routes.ONBOARDING : Routes.HOME;
  }

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_DETAILS,
      page: () => const ImageDetails(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_APP,
      page: () => const MyApp(),
      binding: MyAppBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
