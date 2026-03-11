import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../../../core/app_service/user_session_service.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/theme_manager.dart';
import '../../../features/auth/models/user_model.dart';

class SettingsController extends GetxController {
  final ThemeManager _themeManager = Get.find<ThemeManager>();

  final Rx<UserModel?> user = Rx<UserModel?>(null);

  bool get isDarkMode => _themeManager.currentThemeMode == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    user.value = UserSessionService.getCachedUser();
  }

  void toggleTheme(bool value) {
    _themeManager.toggleTheme(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> logout() async {
    final bool? confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await UserSessionService.clearSession();
      Get.offAllNamed(AppRoutes.signIn);
    }
  }
}
