import 'package:flutter/material.dart';

import '../config/app_colors.dart' show AppColors;

class AppTextTheme{
  AppTextTheme._();
  static  TextTheme lightTextTheme = TextTheme(
    /// Button text ========>
    labelMedium: TextStyle(
      color: AppColors.textBlackColor,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),

    /// for large labels =============>
    titleLarge: TextStyle(
      color: AppColors.textBlackColor,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),

    /// for heading texts =====>
    headlineMedium: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 19,
      fontWeight: FontWeight.w700,
    ),

    /// for regular text ====>
    bodyMedium: TextStyle(
      color: AppColors.greyTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    /// for smaller body text ====>
    bodySmall: TextStyle(
      color: AppColors.greyDarkTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    /// Button text ========>
    labelMedium: TextStyle(
      color: AppColors.darkWhiteColor,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),

    /// for large labels =============>
    titleLarge: TextStyle(
      color: AppColors.darkGreyTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),

    /// for heading texts =====>
    headlineMedium: TextStyle(
      color: AppColors.darkPrimaryColor,
      fontSize: 19,
      fontWeight: FontWeight.w700,
    ),

    /// for regular text ====>
    bodyMedium: TextStyle(
      color: AppColors.darkTextBlackColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    /// for smaller body text ====>
    bodySmall: TextStyle(
      color: AppColors.darkGreyDarkTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}

