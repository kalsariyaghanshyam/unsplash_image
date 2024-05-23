import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final RefreshController refreshController = RefreshController(initialRefresh: false);

//==============================================================================
// ** GetX Life Cycle **
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

  refreshData(){
    isLoading(true);
    getImageData(page: 1);
    isLoading(false);
  }

  Future<void> getImageData({required int page}) async {
    isLoading(true);
    try {
      final response = await Repo.getInstance().getImageData(page: page);
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
