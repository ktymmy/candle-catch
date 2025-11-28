//新規登録画面
import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';
import 'package:candlecatch/view/components/form.dart';
import 'package:candlecatch/view/components/button.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; // 844
    final width = MediaQuery.of(context).size.width; // 390
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            SizedBox(height: height * 0.08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _SinUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}

// ヘッダー
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; // 844
    final width = MediaQuery.of(context).size.width; // 390
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: _HeaderTitle(),
            ),
          ),
          Positioned(top: height * 0.02, left: 0, child: AppBackButton()),
        ],
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '新規登録',
          style: TextStyle(
            fontFamily: "Corporate Logo Rounded Bold",
            fontSize: 32, // TODO:フォントサイズレスポンシブ対応
          ),
        ),
      ],
    );
  }
}

// グラデーションぼたん (仮)
class _HeaderBackButtonEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; // 844
    final width = MediaQuery.of(context).size.width; // 390
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: width * 0.11,
        height: height * 0.05,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.kBrandGradient, // ←背景をグラデーションに！
        ),
        child: const Icon(
          Icons.chevron_left,
          color: AppColors.textWhite, // 白い矢印の方が映える！
          size: 28, // TODO: レスポンシブ対応
        ),
      ),
    );
  }
}

class _SinUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CustomTextField(
          labelText: 'メールアドレス',
          hintText: 'aaaaa@ac.jp',
          obscureText: false,
        ),
        SizedBox(height: height * 0.04),
        CustomTextField(labelText: '名前', hintText: 'そた', obscureText: false),
        SizedBox(height: height * 0.04),
        CustomTextField(
          labelText: 'ID',
          hintText: 'sota_sota',
          obscureText: false,
        ),
        SizedBox(height: height * 0.04),
        CustomTextField(
          labelText: 'パスワード',
          hintText: '************',
          obscureText: true,
        ),
        SizedBox(height: height * 0.12),
        BrandGradientButton(
          text: '新規登録',
          onPressed: () {}, // TODO: 登録処理
        ),
      ],
    );
  }
}
