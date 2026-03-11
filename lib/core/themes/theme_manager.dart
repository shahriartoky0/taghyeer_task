import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import '../config/app_constants.dart';
import '../storage/secured_storage_model.dart';
 import '../utils/logger_utils.dart';

class ThemeManager extends GetxController {
  final SecureStorageService _storage = SecureStorageService();
  UniqueKey themeKey = UniqueKey();

  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  Brightness getBrightness(BuildContext context) {
    if (_themeMode.value == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness;
    }
    return _themeMode.value == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }

  bool isDarkMode(BuildContext context) {
    return getBrightness(context) == Brightness.dark;
  }

  ThemeMode get currentThemeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void toggleTheme(ThemeMode? mode) {
    mode ??= currentThemeMode;
    _themeMode.value = mode;
    _saveTheme(mode);
    Get.changeThemeMode(mode);
    themeKey = UniqueKey();
  }

  Future<void> _loadTheme() async {
    debugPrint("Checking Storage...");
    final String? savedTheme = await _storage.read(AppConstants.themeMode);
    debugPrint("Loaded Theme from Storage: $savedTheme");
    if (savedTheme != null) {
      switch (savedTheme) {
        case AppConstants.lightMode:
          _themeMode.value = ThemeMode.light;
          break;
        case AppConstants.darkMode:
          _themeMode.value = ThemeMode.dark;
          break;
        default:
          _themeMode.value = ThemeMode.light;
      }
    } else {
      debugPrint("Theme is NULL. Defaulting to light.");
      _themeMode.value = ThemeMode.light;
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    String themeString = AppConstants.systemMode;
    if (mode == ThemeMode.light) {
      themeString = AppConstants.lightMode;
    } else if (mode == ThemeMode.dark) {
      themeString = AppConstants.darkMode;
    }
    LoggerUtils.info("Stored Theme Mode: $themeString");
    await _storage.write(AppConstants.themeMode, themeString);
    Restart.restartApp();
  }
}
