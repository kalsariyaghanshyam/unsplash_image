import '../../model/image_response_model.dart';
import '../index.dart';

class RepoImpl extends Repository {
  RepoImpl({required DataProvider dataProvider}) : _dataProvider = dataProvider;

  final DataProvider _dataProvider;

//============================= Api =====================================
  @override
  Future<ImageResponseModel> getImageData({required int page}) {
    return _dataProvider.getImageData(page: page);
  }
}
