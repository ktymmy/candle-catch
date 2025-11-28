/***
**
*このpage新しくdevalopからpullするたびに自分のファイルにかきなおしてねーーー
 */


import 'package:flutter/material.dart';
//import './view/page/navibar.dart';
//import './view/page/src/alert.dart'; 
// import './const/colorConst.dart';
import './view/page/addFriends/my_qr_screen.dart'; 



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
      home: const MyQrScreen(),
      //home: NotificationScreen(),
      //home: Navibar(),
    );
  }
}
