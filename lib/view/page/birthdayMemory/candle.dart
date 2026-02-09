//PAGE: 年ごとのベストショットとキャンドルページ
//TODO:戻るボタン追加

import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';
import '../../components/candle/candleTable.dart';

class candle extends StatelessWidget {
  final String year;
  final String imagePath;

  const candle({super.key, required this.year, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/candleBackScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: height * 0.05)),

              Align(
                alignment: Alignment.centerLeft,

                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textWhite),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              _BestShot(year: year, imagePath: imagePath),
              SizedBox(height: height * 0.03),

              Container(width: width, child: CandleTable()),
            ],
          ),
        ),
      ),
    );
  }
}

class _BestShot extends StatelessWidget {
  final String year;
  final String imagePath;

  const _BestShot({super.key, required this.year, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 誕生日表示
        Text(
          year,
          style: const TextStyle(
            //TODO:font見直す
            fontFamily: "Corporate Logo Rounded Bold",
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: height * 0.03),
        Text(
          'ベストショット',
          style: const TextStyle(
            //TODO:font見直す
            // fontFamily: "Corporate Logo Rounded Bold",
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: height * 0.02),

        Hero(
          tag: "$imagePath-$year",
          child: Container(
            width: width * 0.57,
            height: height * 0.35,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
