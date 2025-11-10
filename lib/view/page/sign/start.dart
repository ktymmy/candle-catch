//新規登録かログインか選ぶ画面
import 'package:flutter/material.dart';
import 'package:candlecatch/view/page/sign/signIn.dart';
import 'package:candlecatch/view/page/sign/signUp.dart';
import 'package:candlecatch/constants/colors.dart';
import 'package:candlecatch/view/components/button.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Corporate Logo Rounded Bold", //Textの字体や大きさ
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: "Corporate Logo Rounded Bold"),
        ),
      ),
      title: 'Candle Catch',
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Header(),
              SizedBox(height: height * 0.1),
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}

// ヘッダー
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Image.asset('images/signInPageImage.png', width: 367)],
    );
  }
}

class _body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrandGradientButton(
          text: '新規登録',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
        ),
        SizedBox(height: 16),
        BrandGradientButton(
          text: 'ログイン',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
        ),
      ],
    );
  }
}
