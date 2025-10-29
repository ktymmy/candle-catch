import 'package:flutter/material.dart';

class AppColors {
  // 背景色
  static const Color background = Color(0xFFFFF8E7);

  // グラデーション色
  static const Color gradientStart = Color(0xffF6D365);
  static const Color gradientEnd = Color(0xffFDA085);
  static const LinearGradient kBrandGradient = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // テキスト色
  static const Color textBlack = Color(0xff1E2A54);
  static const Color textWhite = Color(0xFFFFF8E7);
}
