import 'package:flutter/material.dart';

class AppColors {
  // 背景色
  static const Color background = Color(0xFFFFF8E7);
  static const Color bt = Color(0xffFDA085);

  // グラデーション色
  static const Color gradientStart = Color(0xffF6D365);
  static const Color gradientEnd = Color(0xffFDA085);
  static const LinearGradient kBrandGradient = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient kBrandGradientWidth = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static final BarColor = ColorTween(begin: gradientStart, end: gradientEnd);

  // テキスト色
  static const Color textBlack = Color(0xff1E2A54);
  static const Color textLightBlack = Color(0xff6D6D6D);
  static const Color textWhite = Color(0xFFFFF8E7);

  static const Color textPrimary = Color(0xFF333333);
  static const Color accentOrange = Color(0xFFFFAB91);
}
