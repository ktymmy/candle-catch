//ボタンのコンポーネント
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    this.text = 'DEFAULT',


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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.05,
      width: width * 0.4,
      decoration: BoxDecoration(
        gradient: AppColors.kBrandGradient,
        boxShadow: [
          BoxShadow(
            //TODO:Boxに影つける
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Container(
          child: Text(text, style: TextStyle(color: AppColors.textWhite)),
        ),
      ),
    );
  }
}
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
