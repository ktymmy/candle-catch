import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './view/page/navibar.dart';

// import './const/colorConst.dart';

void main() async {
  // flutterEngineが初期化されるのを保証
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseの初期化処理
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
