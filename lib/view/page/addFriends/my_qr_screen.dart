// PAGE:マイQRコード画面

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // クリップボード用
// import 'package:share_plus/share_plus.dart'; // TODO:シェア機能用
import 'package:flutter/foundation.dart' show kIsWeb; // Web判定用
import 'qr_scan_screen.dart'; // 次の画面への遷移用
import 'package:candlecatch/constants/colors.dart';
import '../../components/button.dart';
import './friend_profile_screen.dart';

class MyQrScreen extends StatelessWidget {
  final String userId;
  const MyQrScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // 画面サイズ
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.bt, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),

            Container(
              width: width * 0.7,
              alignment: Alignment.centerRight,
              child: TopCircleButton(
                size: 55,
                icon: Icons.qr_code_2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrScanScreen(),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: size.height * 0.05),

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
                        border: Border.all(
                          color: AppColors.textPrimary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.qr_code_2,
                        size: 150,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // ID
                    Text(
                      userId,
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
            SizedBox(height: size.height * 0.05),

            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // シェアボタン、chromeでの確認なので実機で期待している動作ができるかは不明
                  ActionButton(
                    icon: Icons.share,
                    label: 'シェア',
                    onTap: () {
                      if (kIsWeb) {
                        _showSnackBar(context, 'シェア画面を開きます');
                      } else {
                        // Share.share('私のCandleCatch IDは sota_sota です！ https://candlecatch.com/id/sota_sota');
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  // リンクコピー
                  ActionButton(
                    icon: Icons.link,
                    label: 'リンクコピー',
                    onTap: () {
                      Clipboard.setData(
                        const ClipboardData(
                          text: "https://candlecatch.com/id/sota_sota",
                        ),
                      );
                      _showSnackBar(context, 'リンクをコピーしました！');
                    },
                  ),
                  const SizedBox(width: 15),
                  // ダウンロード
                  ActionButton(
                    icon: Icons.download,
                    label: 'ダウンロード',
                    onTap: () => _showSnackBar(context, 'QRコードをダウンロードしました！'),
                  ),
                  const SizedBox(width: 15),
                  // ID検索
                  ActionButton(
                    icon: Icons.search,
                    label: 'ID検索',
                    onTap: () => _showIdSearchDialog(context),
                  ),
                ],
              ),
            ),
          ],
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
          backgroundColor: AppColors.background,
          title: const Text('ID検索'),
          content: TextField(
            controller: _controller,
            cursorColor: Colors.grey,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: "検索したいIDを入力",
              hintStyle: TextStyle(color: Colors.grey.shade500),

              filled: true,
              fillColor: const Color(0xFFF2F2F7), // iOS風グレー

              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // 枠線なし
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル', style: TextStyle(color: AppColors.bt)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.bt),
              onPressed: () {
                final id = _controller.text.trim();
                Navigator.pop(context);

                if (id.isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FriendProfileScreen(friendUid: id),
                  ),
                );
              },
              child: const Text(
                '検索',
                style: TextStyle(color: AppColors.textWhite),
              ),
            ),
          ],
        );
      },
    );
  }
}
