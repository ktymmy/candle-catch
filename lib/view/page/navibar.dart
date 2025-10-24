//ナビゲーションバーのコンポーネント

import 'package:flutter/material.dart';

import './src/home.dart';
import './src/profile.dart';
import './src/B-signal.dart';

class Navibar extends StatefulWidget {
  const Navibar({super.key});

  @override
  State<Navibar> createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  static const _screens = [Bsignal(), Home(), Profile()];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'B-signal',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
