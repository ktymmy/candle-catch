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
