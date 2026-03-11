import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/config/app_constants.dart';
import 'core/routes/app_navigation.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/theme.dart';
import 'core/themes/theme_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final ThemeManager themeManager = Get.put(ThemeManager());
  await Future.delayed(const Duration(milliseconds: 200));

  final bool isLoggedIn = GetStorage().read(AppConstants.isLoggedIn) ?? false;

  runApp(
    MyApp(
      themeManager: themeManager,
      initialRoute: isLoggedIn ? AppRoutes.mainNav : AppRoutes.signIn,
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeManager themeManager;
  final String initialRoute;

  const MyApp({super.key, required this.themeManager, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        key: navigatorKey,
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(ThemeMode.light),
        darkTheme: AppTheme.getTheme(ThemeMode.dark),
        themeMode: themeManager.currentThemeMode,
        initialRoute: initialRoute,
        getPages: AppPages.routes,
      ),
    );
  }
}
