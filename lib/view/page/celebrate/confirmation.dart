//メッセージ、ギフト確認画面
import 'package:flutter/material.dart';
import '../../components/gift/send_button.dart';
import '../../../constants/colors.dart';

class GiftConfirmPage extends StatelessWidget {
  const GiftConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          const Text('sotaさんに', style: TextStyle(fontSize: 18)),
          SizedBox(height: height * 0.05),
          Image.asset('images/card.png', width: 220),
          SizedBox(height: height * 0.05),
          Container(
            height: height * 0.15,
            width: width * 0.8,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 0, 48, 2),
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/cofee.jpg', width: 80),
                const SizedBox(width: 16),
                const Text(
                  '¥1,000（500円×2）\nドリンクチケット\nスターバックス',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          const Spacer(),
          SendButton(
            text: '送る',
            onPressed: () {
              _showFinishedDialog(context);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎂', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                const Text(
                  'ギフトを送信しました',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bt,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context, rootNavigator: true).pop();
                  },

                  child: const Text(
                    'とじる',
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
