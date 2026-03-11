import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/theme_manager.dart';

// class AppColors {
//   AppColors._();
//
//   static const Color primaryColor = Color(0xFFB2CBF2);
//   static const Color secondaryColor = Color(0xFFABE6ED);
//   static const Color primaryLightColor = Color(0xFFB2CBF2);
//
//   static const Color backgroundColor = Color(0xFFFFFFFF);
//   static const Color surfaceColor = Color(0xFFEFFAFC);
//   static const Color navIconColor = Color(0xFF685F84);
//   static const Color bottomBarColor = Color(0xFFD3F0F5);
//
//   // static const Color buttonDisabledColor = Color(0xFFc4c4c4);
//   static const Color redColor = Color(0xFFFF4F4F);
//   static const Color successColor = Color(0xFF81C784);
//   static const Color warningColor = Color(0xFFFF8A50);
//   static const Color infoColor = Color(0xFF64B5F6);
//
//   static const Color greyDarkColor = Color(0xFF999899);
//   static const Color greyColor = Colors.grey;
//   static const Color blackColor = Color(0xFF161C20);
//   static const Color whiteColor = Colors.white;
//
//   static const Color textBlackColor = Color(0XFF303F47);
//
//   static const Color borderColor = Color(0x28333F40);
//   static const Color dividerColor = Color(0xFFBDBDBD);
//
//   static const Color borderSecondaryColor = Color(0XFFD4A200);
//
//   // Text Colors ============>
//   static const Color greyDarkTextColor = Color(0XFF666666);
//   static const Color greyTextColor = Color(0XFF606060);
// }


class AppColors {
  AppColors._();

  // ==================== LIGHT THEME COLORS ====================
  static const Color lightPrimaryColor = Color(0xFFB2CBF2);
  static const Color lightSecondaryColor = Color(0xFFABE6ED);
  static const Color lightPrimaryLightColor = Color(0xFFB2CBF2);

  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightSurfaceColor = Color(0xFFEFFAFC);
  static const Color lightNavIconColor = Color(0xFF685F84);
  static const Color lightBottomBarColor = Color(0xFFD3F0F5);

  static const Color lightRedColor = Color(0xFFFF4F4F);
  static const Color lightSuccessColor = Color(0xFF81C784);
  static const Color lightWarningColor = Color(0xFFFF8A50);
  static const Color lightInfoColor = Color(0xFF64B5F6);

  static const Color lightGreyDarkColor = Color(0xFF999899);
  static const Color lightGreyColor = Colors.grey;
  static const Color lightBlackColor = Color(0xFF161C20);
  static const Color lightWhiteColor = Colors.white;

  static const Color lightTextBlackColor = Color(0XFF303F47);

  static const Color lightBorderColor = Color(0x28333F40);
  static const Color lightDividerColor = Color(0xFFBDBDBD);

  static const Color lightBorderSecondaryColor = Color(0XFFD4A200);

  static const Color lightGreyDarkTextColor = Color(0XFF666666);
  static const Color lightGreyTextColor = Color(0XFF606060);

  static const Color lightOrangeColor = Color(0xFFFF9800);


  // ==================== DARK THEME COLORS ====================
  static const Color darkPrimaryColor = Color(0xFF6B9BD8);
  static const Color darkSecondaryColor = Color(0xFF7BC5CC);
  static const Color darkPrimaryLightColor = Color(0xFF8BADD6);

  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkNavIconColor = Color(0xFFB8B0D4);
  static const Color darkBottomBarColor = Color(0xFF2C3E44);

  static const Color darkRedColor = Color(0xFFEF5350);
  static const Color darkSuccessColor = Color(0xFF66BB6A);
  static const Color darkWarningColor = Color(0xFFFF7043);
  static const Color darkInfoColor = Color(0xFF42A5F5);

  static const Color darkGreyDarkColor = Color(0xFFB0B0B0);
  static const Color darkGreyColor = Color(0xFF9E9E9E);
  static const Color darkBlackColor = Color(0xFF000000);
  static const Color darkWhiteColor = Color(0xFF1E1E1E);

  static const Color darkTextBlackColor = Color(0xFFE0E0E0);

  static const Color darkBorderColor = Color(0x33FFFFFF);
  static const Color darkDividerColor = Color(0xFF424242);

  static const Color darkBorderSecondaryColor = Color(0xFFE5B800);

  static const Color darkGreyDarkTextColor = Color(0xFFB0B0B0);
  static const Color darkGreyTextColor = Color(0xFFA0A0A0);


  static const Color darkOrangeColor = Color(0xFFFF7043);

  // ==================== DYNAMIC GETTERS ====================
  // These methods return colors based on current theme

  static Color get primaryColor=>
       Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkPrimaryColor : lightPrimaryColor;

  static Color get secondaryColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkSecondaryColor : lightSecondaryColor;

  static Color get primaryLightColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkPrimaryLightColor : lightPrimaryLightColor;

  static Color get backgroundColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkBackgroundColor : lightBackgroundColor;

  static Color get surfaceColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkSurfaceColor : lightSurfaceColor;

  static Color get navIconColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkNavIconColor : lightNavIconColor;

  static Color get bottomBarColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkBottomBarColor : lightBottomBarColor;

  static Color get redColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkRedColor : lightRedColor;

  static Color get successColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkSuccessColor : lightSuccessColor;

  static Color get warningColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkWarningColor : lightWarningColor;

  static Color get infoColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkInfoColor : lightInfoColor;

  static Color get greyDarkColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkGreyDarkColor : lightGreyDarkColor;

  static Color get greyColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkGreyColor : lightGreyColor;

  static Color get blackColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkBlackColor : lightBlackColor;

  static Color get whiteColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkWhiteColor : lightWhiteColor;

  static Color get textBlackColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkTextBlackColor : lightTextBlackColor;

  static Color get borderColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkBorderColor : lightBorderColor;

  static Color get dividerColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkDividerColor : lightDividerColor;

  static Color get borderSecondaryColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkBorderSecondaryColor : lightBorderSecondaryColor;

  static Color get greyDarkTextColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkGreyDarkTextColor : lightGreyDarkTextColor;

  static Color get greyTextColor=>
      Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark ? darkGreyTextColor : lightGreyTextColor;

  static Color get orangeColor => Get.find<ThemeManager>().currentThemeMode == ThemeMode.dark
      ? darkOrangeColor
      : lightOrangeColor;
}