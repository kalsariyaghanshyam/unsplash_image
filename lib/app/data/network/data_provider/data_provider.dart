import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unsplash_img/app/constants/constants.dart';

import '../../../model/image_response_model.dart';

class DataProvider {
  DataProvider();

//============================= headers ========================================
  Map<String, String> _getHeader() {
    return <String, String>{
      'content-type': 'application/problem+json; charset=utf-8',
      'transfer-encoding': 'chunked',
    };
  }

  String errorMessage(http.Response response) {
    String responseJson = response.body;
    Map<String, dynamic> jsonResponse = jsonDecode(responseJson);
    String errorMessage = jsonResponse["Message"];
    return errorMessage;
  }

//========================= Get image Api =======================================

  Future<ImageResponseModel> getImageData({required int page}) async {
    String url =
        "${AppConstant.baseUrl}/?key=43665918-2c127bfecf71bdcf83faa86cc&page=$page&per_page=50";
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return ImageResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get Category Data.');
    }
  }
}
