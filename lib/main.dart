import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/myApp/views/my_app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}
