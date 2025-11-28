import 'package:flutter/material.dart';

// 色定義
class AppColors {
  static const Color textPrimary = Color(0xFF333333);
  static const Color accentOrange = Color(0xFFFFAB91);
}

class FriendProfileScreen extends StatefulWidget {
  const FriendProfileScreen({super.key});

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  // リクエストが送信されたかどうかを管理するフラグ
  bool _isRequestSent = false;

  void _sendRequest() {
    setState(() {
      _isRequestSent = true;
    });

    // 3秒後に自動的に前の画面に戻る場合（オプション）
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/candleBackScreen.png'), // 背景画像
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 戻るボタン
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 35),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // 中央のプロフィールカード
              Center(
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1), // クリーム色背景
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // アイコン画像
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://placehold.co/100x100/png?text=Icon'), // ダミー画像
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      // 名前
                      const Text(
                        'mmmmmm',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // 友達リクエストを送るボタン
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          // すでに送信済みの場合はボタンを押せないようにする（nullを指定すると無効化される）
                          onPressed: _isRequestSent ? null : _sendRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFCC80), // オレンジ
                            disabledBackgroundColor: Colors.grey[300], // 無効化時の色
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _isRequestSent ? '送信済み' : '友達リクエストを送る',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // キャンセルボタン
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'キャンセル',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ★完了通知 (フラグが true の時だけ表示)
              if (_isRequestSent)
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    // ふわっと表示させるアニメーション（任意ですが見栄えが良いです）
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)), // 下から浮き上がる動き
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'リクエストを送信しました！',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}