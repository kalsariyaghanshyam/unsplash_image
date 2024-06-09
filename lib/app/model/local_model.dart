import 'package:get/get.dart';

class Onboarding {
  final String image;
  final String dec;

  Onboarding({required this.image, required this.dec});
}

class FilterList {
  final String title;
  List<FilterChild> filterChild;

  FilterList({required this.title, required this.filterChild});
}

class FilterChild {
  final String text;
  RxBool isClick;

  FilterChild({required this.text, bool isClick = false})
      : isClick = RxBool(isClick);
}

class FilterArg {
  final int? page;
  final int? pageSize;
  final String? category;
  final String? imageType;
  final String? orientation;
  final String? order;

  FilterArg({this.page,
    this.pageSize,
    this.category,
    this.imageType,
    this.order,
    this.orientation});
}

class OrientationData {
  final String img;
  final String title;
  RxBool isClick;

  OrientationData

  (

  {

  required

  this

      .

  img, required this.title, bool isClick = false
}):
isClick =

RxBool(isClick);}
