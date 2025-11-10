//ボタンのコンポーネント

import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';

// グラデーション四角ボタン
class BrandGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BrandGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 196,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.kBrandGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 32,
            fontFamily: "Corporate Logo Rounded Bold",
          ),
        ),
      ),
    );
  }
}

// バックボタン
class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Icon(
        Icons.chevron_left,
        color: AppColors.textBlack,
        size: 34,
      ), // TODO: レスポンシブ対応
    );
  }
}
