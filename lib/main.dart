import 'package:flutter/material.dart';
import './view/page/navibar.dart';
// import './const/colorConst.dart';

void main() {
  runApp(const MyApp());
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
        // scaffoldBackgroundColor: ColorConst.main,
      ),
      home: Navibar(),
    );
  }
}
