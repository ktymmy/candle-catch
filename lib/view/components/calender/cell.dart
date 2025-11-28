import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  const Cell({super.key});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      width: width * 0.2,
      decoration: BoxDecoration(border: Border.all()),

      child: Column(
        children: [
          Text('1'),
          //TODO:imageの形を四角にする
          Container(
            height: height * 0.1,
            width: width * 0.2,
            child: Image.asset("icon/img_5.jpg"),
          ),
          Text('miyu'),
        ],
      ),
    );
  }
}
