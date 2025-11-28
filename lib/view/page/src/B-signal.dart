//B-signalの通知画面　Navibar左下
import 'package:flutter/material.dart';
import '../../components/calender/cell.dart';

import '../../components/calender/calendar.dart';

class Bsignal extends StatefulWidget {
  const Bsignal({super.key});

  @override
  State<Bsignal> createState() => _BsignalState();
}

class _BsignalState extends State<Bsignal> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(child: CalendarTable()),
            Container(child: Cell()),
          ],
        ),
      ),
    );
  }
}
