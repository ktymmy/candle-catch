//PAGE:B-signalの通知画面　Navibar左下
import 'package:flutter/material.dart';

import '../../../model/b-signal_model.dart';
import '../../../data/b-signal_data.dart'; //仮データ
import '../../components/button.dart';
import '../../../constants/colors.dart';
import '../celebrate/confirmation.dart';

class Bsignal extends StatefulWidget {
  const Bsignal({super.key});

  @override
  State<Bsignal> createState() => _BsignalState();
}

class _BsignalState extends State<Bsignal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            // _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return _buildListItem(users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'すれ違い一覧',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          //TODO:このアイコンの意味
          // Positioned(
          //   right: 0,
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.white,
          //     ),
          //     child: const Text(
          //       '10/10',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Container(
  //       height: 40,
  //       decoration: BoxDecoration(
  //         color: Colors.grey.shade300,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: const Row(
  //         children: [
  //           SizedBox(width: 12),
  //           Icon(Icons.search, color: Colors.grey),
  //           SizedBox(width: 8),
  //           Text('検索', style: TextStyle(color: Colors.grey)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildListItem(EncounterUser user) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.accentOrange,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(user.name, style: const TextStyle(fontSize: 16)),
          ),
          Container(
            width: width * 0.25,
            child: BrandGradientButton(
              text: '祝う',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GiftConfirmPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
