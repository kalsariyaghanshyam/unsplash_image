import 'dart:io';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/index.dart';
import '../../../data/index.dart';
import '../../../model/index.dart';
import '../../../reusable/index.dart';

class HomeController extends GetxController {
//==============================================================================
// ** Property **
//==============================================================================
  var isLoading = false.obs;
  var isLiked = false.obs;
  final TextEditingController searchController = TextEditingController();
  FocusNode focus = FocusNode();
  Rx<ImageResponseModel> imgDataResponse = ImageResponseModel().obs;
  var filteredHits = <Hit>[].obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Debounce debounce = Debounce(const Duration(milliseconds: 500));

  List<FilterList> drawerItem = [
    FilterList(title: 'Image Type', filterChild: [
      FilterChild(text: 'photo'),
      FilterChild(text: 'illustration'),
      FilterChild(text: 'vector')
    ]),
    FilterList(title: 'Category', filterChild: [
      FilterChild(text: "backgrounds"),
      FilterChild(text: "fashion"),
      FilterChild(text: "nature"),
      FilterChild(text: "science"),
      FilterChild(text: "education"),
      FilterChild(text: "feelings"),
      FilterChild(text: "health"),
      FilterChild(text: "religion"),
      FilterChild(text: "places"),
      FilterChild(text: "animals"),
      FilterChild(text: "industry"),
      FilterChild(text: "computer"),
      FilterChild(text: "food"),
      FilterChild(text: "sports"),
      FilterChild(text: "transportation"),
      FilterChild(text: "travel"),
      FilterChild(text: "buildings"),
      FilterChild(text: "business"),
      FilterChild(text: "music"),
    ]),
  ].obs;

  List<OrientationData> orientationList = [
    OrientationData(img: AssetStrings.horizontal, title: 'horizontal'),
    OrientationData(img: AssetStrings.vertical, title: 'vertical'),
  ].obs;

//==============================================================================
// ** GetX Life cycle  **
//==============================================================================
  @override
  void onInit() {
    getImageData(page: 1);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    focus.dispose();
    debounce.dispose();
    super.onClose();
  }

//==============================================================================
// ** Helper Function **
//==============================================================================

  Future<void> downloadImage(String url) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
      }
      
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Dio().download(url, path);
      await Gal.putImage(path);
      
      Get.back(); // close dialog
      Get.snackbar('Success', 'Image downloaded successfully!', 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      Get.back(); // close dialog
      Get.snackbar('Error', 'Failed to download image', 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
      appPrint(e);
    }
  }

  Future<void> setWallpaper(String url) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      
      // Set to both home and lock screen
      bool result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: false,
      );

      Get.back(); // close dialog
      if (result) {
        Get.snackbar('Success', 'Wallpaper set successfully!', 
            snackPosition: SnackPosition.BOTTOM, 
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to set wallpaper', 
            snackPosition: SnackPosition.BOTTOM, 
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white);
      }
    } on PlatformException catch (e) {
      Get.back(); // close dialog
      Get.snackbar('Error', 'Failed to set wallpaper', 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
      appPrint(e);
    }
  }

  Future<void> refreshData() async {
    await getImageData(page: 1);
  }

  void searchData(String query) {
    filteredHits.value = RxList<Hit>.from(imgDataResponse.value.hits
            ?.where((hit) =>
                hit.tags != null &&
                hit.tags!.toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        []);
  }

  Future<void> getImageData(
      {required int page,
      String? category,
      String? imageType,
      String? orientation}) async {
    isLoading(true);
    try {
      final response = await Repo.getInstance().getImageData(
        filterData: FilterArg(
            page: page,
            category: category,
            imageType: imageType,
            orientation: orientation),
      );
      imgDataResponse.value = response;
      filteredHits.value = imgDataResponse.value.hits ?? [];
    } catch (e) {
      appPrint(e);
    } finally {
      isLoading(false);
      refreshController.refreshCompleted();
    }
  }
}
