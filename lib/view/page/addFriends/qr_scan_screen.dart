import 'package:flutter/material.dart';
import 'friend_profile_screen.dart'; // プロフィール画面への遷移用

class QrScanScreen extends StatelessWidget {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // カメラプレビューの代わりの黒背景
      body: Stack(
        children: [
          // カメラプレビューのモック
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black54,
              child: const Center(
                child: Text(
                  'カメラ起動中...',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),
          
          // スキャン枠
          Center(
            child: GestureDetector(
              onTap: () {
                // タップで読み取り成功とみなし、次の画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FriendProfileScreen()),
                );
              },
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // 四隅の装飾
                    Positioned(top: 10, left: 10, child: _CornerMark(0)),
                    Positioned(top: 10, right: 10, child: _CornerMark(1)),
                    Positioned(bottom: 10, left: 10, child: _CornerMark(2)),
                    Positioned(bottom: 10, right: 10, child: _CornerMark(3)),
                    
                    // 中央のQRイメージ
                    const Center(
                      child: Icon(Icons.qr_code, color: Colors.white, size: 180),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ヘッダー (戻るボタン)
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white, size: 35),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          

          // 下部の案内テキスト
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'QRコードをスキャン',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 四隅のマークを描画するウィジェット
class _CornerMark extends StatelessWidget {
  final int position; // 0:TL, 1:TR, 2:BL, 3:BR
  const _CornerMark(this.position);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: (position < 2) ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
          bottom: (position >= 2) ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
          left: (position % 2 == 0) ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
          right: (position % 2 != 0) ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}