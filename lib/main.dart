import 'package:flutter/material.dart';
import 'app/modules/myApp/views/my_app_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(const Duration(milliseconds: 200), () {
    runApp(const MyApp());
  });
}
