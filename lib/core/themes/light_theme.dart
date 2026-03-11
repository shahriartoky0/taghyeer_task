import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';
import 'app_text_theme.dart';

class LightTheme {
  LightTheme._();

  static final ThemeData lightTheme = ThemeData(
    fontFamily: "arial-mt-bold",
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
    ).copyWith(brightness: Brightness.light),
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
     textTheme: AppTextTheme.lightTextTheme,
     iconTheme: const IconThemeData(opacity: 1),
     inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: AppColors.greyDarkColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxxL),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxxL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxxL),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
      errorStyle: TextStyle(
        color: AppColors.redColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: AppSizes.sm)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: AppSizes.sm)),
    ),

    /// for chip theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        side: BorderSide(color: AppColors.secondaryColor),
      ),
    ),
    dividerColor: Colors.grey,
    dividerTheme: const DividerThemeData(color: Colors.grey),

  );
}
