import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './view/page/navibar.dart';
import './constants/colors.dart';

Future<void> main() async {
  await initializeDateFormatting('ja_JP').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candle Catch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: Navibar(),
    );
  }
}
