import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // クリップボード用
import 'package:share_plus/share_plus.dart'; // シェア機能用
import 'package:flutter/foundation.dart' show kIsWeb; // Web判定用
import 'qr_scan_screen.dart'; // 次の画面への遷移用

// 色定数
class AppColors {
  static const Color textPrimary = Color(0xFF333333);
  static const Color textWhite = Colors.white;
  static const Color accentOrange = Color(0xFFFFAB91);
}

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面サイズ
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      // 背景画像を全体に設定
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
          child: Stack(
            children: [
              // コンテンツ部分
              Column(
                children: [
                  // ヘッダー
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 閉じるボタン
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                        // QRスキャン画面へ遷移するボタン
                        IconButton(
                          icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const QrScanScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.1),

                  // QRコードカード
                  Center(
                    child: Container(
                      width: size.width * 0.7,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFE082), Color(0xFFFFAB91)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
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
                          // QRコード枠
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textPrimary, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.qr_code_2, size: 150, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 10),
                          // ID
                          const Text(
                            'sota_sota',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // アクションボタン列
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // シェアボタン、chromeでの確認なので実機で期待している動作ができるかは不明
                        _ActionButton(
                          icon: Icons.share,
                          label: 'シェア',
                          onTap: () {
                            if (kIsWeb) {
                              _showSnackBar(context, 'シェア画面を開きます');
                            } else {
                              Share.share('私のCandleCatch IDは sota_sota です！ https://candlecatch.com/id/sota_sota');
                            }
                          },
                        ),
                        const SizedBox(width: 15),
                        // リンクコピー
                        _ActionButton(
                          icon: Icons.link,
                          label: 'リンクコピー',
                          onTap: () {
                            Clipboard.setData(const ClipboardData(text: "https://candlecatch.com/id/sota_sota"));
                            _showSnackBar(context, 'リンクをコピーしました！');
                          },
                        ),
                        const SizedBox(width: 15),
                        // ダウンロード
                        _ActionButton(
                          icon: Icons.download,
                          label: 'ダウンロード',
                          onTap: () => _showSnackBar(context, 'QRコードをダウンロードしました！'),
                        ),
                        const SizedBox(width: 15),
                        // ID検索
                        _ActionButton(
                          icon: Icons.search,
                          label: 'ID検索',
                          onTap: () => _showIdSearchDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showIdSearchDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ID検索'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "検索したいIDを入力"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnackBar(context, '${_controller.text} を検索しました');
              },
              child: const Text('検索'),
            ),
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}