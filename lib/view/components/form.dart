import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';

// テキストフォーム
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: AppColors.bt,
      style: const TextStyle(
        fontSize: 16,
        height: 1.4,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7F7FA),

        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF8E8E93),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),

        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFB0B0B5), fontSize: 15),

        floatingLabelBehavior: FloatingLabelBehavior.always,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none, // 枠線消す
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.bt, width: 1.2),
        ),
      ),
    );
  }
}
