//ログイン画面
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Sign In',
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
