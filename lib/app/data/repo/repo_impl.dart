import '../../model/image_response_model.dart';
import '../../model/index.dart';
import '../index.dart';

class RepoImpl extends Repository {
  RepoImpl({required DataProvider dataProvider}) : _dataProvider = dataProvider;

  final DataProvider _dataProvider;

//============================= Api =====================================
  @override
  Future<ImageResponseModel> getImageData({required FilterArg filterData}) {
    return _dataProvider.getImageData(filterData: filterData);
  }
}
