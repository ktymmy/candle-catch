//ギフト

import 'package:flutter/material.dart';
import '../../components/gift/gift_item.dart';
import './confirmation.dart';

class GiftListPage extends StatelessWidget {
  const GiftListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'オススメギフト\nギフト送るのオススメです',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (_, __) {
            return GiftItem(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GiftConfirmPage()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
