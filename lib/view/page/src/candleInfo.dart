//candleタップした後の詳細画面
import 'package:flutter/material.dart';

class Candleinfo extends StatefulWidget {
  const Candleinfo({super.key});

  @override
  State<Candleinfo> createState() => _CandleinfoState();
}

class _CandleinfoState extends State<Candleinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text('candleの詳細画面')));
  }
}
