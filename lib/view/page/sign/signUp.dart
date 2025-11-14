//新規登録画面
import 'package:flutter/material.dart';

final LinearGradient kBrandGradient = LinearGradient(
  colors: [Color(0xffF6D365), Color(0xffFDA085)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const Color kBackgroundColor = Color(0xFFFFF8E7);

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: "Corporate Logo Rounded Bold",
                  fontSize: 40,
                ),
              ),
              /* ここに、ヘッダー・フォーム・フッターを並べていく */
            ],
          ),
        ),
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
        Text('Welcome', style: TextStyle(color: Colors.black)),
        SizedBox(height: 4),
        Text('Sign in to continue', style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

class _HeaderBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: kBrandGradient.colors[0])),
      ),
      onPressed: () {},
      child: Icon(Icons.chevron_left, color: Colors.black),
    );
  }
}
