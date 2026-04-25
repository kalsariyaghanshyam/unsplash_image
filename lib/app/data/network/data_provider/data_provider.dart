import 'package:dio/dio.dart';
import 'package:unsplash_img/app/constants/constants.dart';

import '../../../model/image_response_model.dart';
import '../../../model/index.dart';

class DataProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.baseUrl.endsWith('/')
        ? AppConstant.baseUrl
        : '${AppConstant.baseUrl}/',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  DataProvider();

//========================= Get image Api =======================================

  Future<ImageResponseModel> getImageData(
      {required FilterArg filterData}) async {
    try {
      final Map<String, dynamic> queryParameters = {
        'key': '43665918-2c127bfecf71bdcf83faa86cc',
        'page': filterData.page ?? 1,
        'per_page': 200,
      };

      if (filterData.category != null && filterData.category!.isNotEmpty) {
        queryParameters['category'] = filterData.category!;
      }
      if (filterData.imageType != null && filterData.imageType!.isNotEmpty) {
        queryParameters['image_type'] = filterData.imageType!;
      }
      if (filterData.orientation != null &&
          filterData.orientation!.isNotEmpty) {
        queryParameters['orientation'] = filterData.orientation!;
      }
      if (filterData.order != null && filterData.order!.isNotEmpty) {
        queryParameters['order'] = filterData.order!;
      }

      final response = await _dio.get(
        '',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return ImageResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load images: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      String errorMessage = _handleDioError(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with API server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in continuation with API server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioExceptionType.badResponse:
        return 'Received invalid status code: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong';
    }
  }
}
