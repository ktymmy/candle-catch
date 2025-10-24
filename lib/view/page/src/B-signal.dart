//B-signalの通知画面　Navibar左下
import 'package:flutter/material.dart';

class Bsignal extends StatefulWidget {
  const Bsignal({super.key});

  @override
  State<Bsignal> createState() => _BsignalState();
}

class _BsignalState extends State<Bsignal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text('Bsignal')));
  }
}
