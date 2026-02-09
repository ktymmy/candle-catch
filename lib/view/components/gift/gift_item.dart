import 'package:flutter/material.dart';

class GiftItem extends StatelessWidget {
  final VoidCallback onTap;

  const GiftItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(child: Image.asset('assets/drink.png')),
          const SizedBox(height: 8),
          const Text(
            '¥1,000（500円×2）\nドリンクチケット\nスターバックス',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
