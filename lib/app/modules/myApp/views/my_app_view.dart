import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/index.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_app_controller.dart';

class MyApp extends GetView<MyAppController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
