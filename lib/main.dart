import './view/page/sign/start.dart';
import './view/page/sign/signUp.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './view/page/sign/signIn.dart';
import './view/page/navibar.dart';
import './constants/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase_options.dartの中身を使う
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Firebase 初期化 (必要ならコメント外す)
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // 日本語ロケールの初期化
  await initializeDateFormatting('ja_JP');

  // アプリ起動
  runApp(const MyApp());
}

// home表示用
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.background,
      title: 'Candle Catch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StartPage(), // TODO: 初期画面に
    );
  }
}

// TODO:本番は↓

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: AppColors.background,
//       title: 'Candle Catch',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       // 起動時に必ずStartpage（選択画面）を表示する
//       home: const StartPage(),
//       //home: const Navibar(), // TODO: 初期画面に
//     ),
//   }
// }
