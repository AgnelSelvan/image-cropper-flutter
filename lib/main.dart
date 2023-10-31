import 'package:flutter/material.dart';
import 'package:image_cropper_example/app.dart';
import 'package:image_cropper_example/utils/db/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((pref) {
    AppSharedPreferences(pref);
  });
  runApp(const MyApp());
}
