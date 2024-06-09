import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    super.onClose();
  }

//==============================================================================
// ** Helper Function **
//==============================================================================

  refreshData() {
    isLoading(true);
    getImageData(page: 1);
    isLoading(false);
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
      isLoading(false);
      appPrint(imgDataResponse.value.toJson());
    } catch (e) {
      appPrint(e);
    } finally {
      refreshController.refreshCompleted();
    }
  }
}
