import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';

// テキストフォーム
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textBlack),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textBlack),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textBlack),
        ),
      ),
      obscureText: obscureText,
      onTap: () {},
    );
  }
}
