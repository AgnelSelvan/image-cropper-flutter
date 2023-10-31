import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._();
  static final AppSharedPreferences instance = AppSharedPreferences._();
  static const String _kImageCropKey = 'image_crop_key';
  static SharedPreferences? sharedPreferences;
  factory AppSharedPreferences(SharedPreferences pref) {
    sharedPreferences = pref;

    return instance;
  }

  Future<void> setImageCropKey(String value) async {
    await sharedPreferences?.setString(_kImageCropKey, value);
  }

  String? getImageCropKey() {
    return sharedPreferences?.getString(_kImageCropKey);
  }
}
