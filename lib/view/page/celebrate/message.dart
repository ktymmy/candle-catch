//メッセージカード
import 'package:flutter/material.dart';
import '../../components/gift/send_button.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'sotaさんに\nお祝いのメッセージ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          Image.asset('assets/card.png', width: 260),
          const Spacer(),
          SendButton(
            text: '送る',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('送信しました 🎉')));
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
