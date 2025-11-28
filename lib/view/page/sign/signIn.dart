//ログイン画面
import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';
import 'package:candlecatch/view/components/button.dart';
import 'package:candlecatch/view/components/form.dart';

class SignIn extends StatelessWidget {
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
            SizedBox(height: height * 0.2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _SinInForm(),
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
          'ログイン',
          style: TextStyle(
            fontFamily: "Corporate Logo Rounded Bold",
            fontSize: 32, // TODO:フォントサイズレスポンシブ対応
          ),
        ),
      ],
    );
  }
}

class _SinInForm extends StatelessWidget {
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
        SizedBox(height: height * 0.05),
        CustomTextField(
          labelText: 'パスワード',
          hintText: '************',
          obscureText: true,
        ),
        GestureDetector(
          onTap: () {}, // TODO: パスワード再設定画面へ
          child: Text(
            'パスワードを忘れた場合',
            style: TextStyle(color: AppColors.textBlack.withOpacity(0.5)),
          ),
        ),
        SizedBox(height: height * 0.12),
        BrandGradientButton(
          text: 'ログイン',
          onPressed: () {}, // TODO: 登録処理
        ),
      ],
    );
  }
}
