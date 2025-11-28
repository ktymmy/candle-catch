import 'package:flutter/material.dart';

// ====================================================
// 1. AppColors (色定数)
// ====================================================

// アプリ全体で使用する色定数を定義
class AppColors {
  // 背景色 (添付画像の色合いを参考に薄いクリーム色系を設定)
  static const Color background = Color(0xFFFFF8E1); 
  
  // メインのテキスト色 (黒系)
  static const Color textPrimary = Color(0xFF333333); 
  
  // 白
  static const Color textWhite = Colors.white; 

  // ブランドグラデーション (新規登録画面のコードに合わせて仮で設定)
  static const LinearGradient kBrandGradient = LinearGradient(
    colors: [
      Color(0xFFFFB6C1), // 薄いピンク
      Color(0xFFFFDAB9), // ピーチ
    ],
    // 縦方向（上から下）
    begin: Alignment.topCenter, 
    end: Alignment.bottomCenter,
  );
}


// ====================================================
// 2. 共通コンポーネント (AppBackButton, CustomBottomBar)
// ====================================================

// 戻るボタン
class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 戻るボタンの遷移処理 (Navigator.pop(context)など) を実装
        print('戻るボタンが押されました (TODO: 実装)');
      },
      child: Container(
        width: 40,
        height: 40,
        // グラデーションや装飾をすべて削除し、透明なコンテナに変更
        alignment: Alignment.center,
        child: const Icon(
          Icons.chevron_left, // 標準の「戻る」アイコン
          color: AppColors.textPrimary, // メインのテキスト色 (黒系) に変更
          size: 28,
        ),
      ),
    );
  }
}

// カスタムボトムバー
class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // 高さを固定
      decoration: BoxDecoration(
        gradient: AppColors.kBrandGradient, // グラデーション背景
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 左のアイコン (リスト/メニュー)
          IconButton(
            icon: Icon(Icons.list, color: AppColors.textWhite, size: 30),
            onPressed: () {
              // TODO: メニュー画面などへの遷移処理
            },
          ),
          // 中央のホームアイコン
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.textWhite.withOpacity(0.2), // アイコン周りの装飾
            ),
            child: IconButton(
              icon: Icon(Icons.home, color: AppColors.textWhite, size: 30),
              onPressed: () {
                // TODO: メイン画面への遷移処理
              },
            ),
          ),
          // 右側のアイコン 
          IconButton(
            icon: Icon(Icons.person, color: AppColors.textWhite, size: 30),
            onPressed: () {
              // TODO: プロフィール画面などへの遷移処理
            },
          ),
        ],
      ),
    );
  }
}

// ====================================================
// 3. NotificationScreen (通知画面の本体)
// ====================================================

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得
    final height = MediaQuery.of(context).size.height; // 844
    final width = MediaQuery.of(context).size.width; // 390

    // 通知データのダミーリスト
    final List<Map<String, dynamic>> notifications = [
      {'date': '1月1日', 'type': 'birthday', 'name': 'miu', 'time': '00:00', 'avatar': 'https://placehold.co/40x40/5A5A5A/FFFFFF?text=M'},
      {'date': '1月4日', 'type': 'celebration', 'name': 'miu', 'time': '13:33', 'avatar': 'https://placehold.co/40x40/F4C430/000000?text=M'},
      {'date': '1月4日', 'type': 'celebration', 'name': 'ながた', 'time': '13:35', 'avatar': 'https://placehold.co/40x40/90EE90/000000?text=N'},
      {'date': '1月4日', 'type': 'celebration', 'name': 'れい', 'time': '14:03', 'avatar': 'https://placehold.co/40x40/ADD8E6/000000?text=R'},
      {'date': '1月7日', 'type': 'birthday', 'name': 'ゾーマ', 'time': '00:00', 'avatar': 'https://placehold.co/40x40/FF6347/FFFFFF?text=Z'},
    ];

    // 通知を日付でグループ化
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};
    for (var notification in notifications) {
      final date = notification['date'] as String;
      if (!groupedNotifications.containsKey(date)) {
        groupedNotifications[date] = [];
      }
      groupedNotifications[date]!.add(notification);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー部分
            _NotificationHeader(height: height, width: width),
            // 通知リスト
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: _NotificationList(groupedNotifications: groupedNotifications),
              ),
            ),
          ],
        ),
      ),
      // ボトムナビゲーションバー
      bottomNavigationBar: CustomBottomBar(), 
    );
  }
}

// ヘッダー
class _NotificationHeader extends StatelessWidget {
  const _NotificationHeader({
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // Row と Spacer を使い、確実に中央に配置する
    return Container(
      height: height * 0.07, // 高さの指定
      padding: EdgeInsets.symmetric(horizontal: width * 0.05), // 全体の横パディング
      child: Row(
        children: [
          // 1. 戻るボタン (左端) - 幅は 40
          AppBackButton(),
          
          // 2. タイトルを中央に配置するための左側のスペース
          const Spacer(), 
          
          // 3. タイトル (中央)
          Text(
            '通知',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          // 4. タイトルを中央に配置するための右側のスペース
          const Spacer(), 

          // 5. 右端のダミー要素 (戻るボタンと同じ幅 40 を確保し、左右のバランスをとる)
          // これにより、タイトルが中央に強制されます。
          const SizedBox(width: 40), 
        ],
      ),
    );
  }
}

// 通知リスト全体
class _NotificationList extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> groupedNotifications;

  const _NotificationList({required this.groupedNotifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupedNotifications.keys.length,
      itemBuilder: (context, index) {
        final date = groupedNotifications.keys.elementAt(index);
        final notificationsForDate = groupedNotifications[date]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日付見出し
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // その日の通知アイテムリスト
            ...notificationsForDate.map((notification) {
              return _NotificationItem(notification: notification);
            }).toList(),
          ],
        );
      },
    );
  }
}

// 個別の通知アイテム
class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;

  const _NotificationItem({required this.notification});

  String _getMessage(String type, String name) {
    switch (type) {
      case 'birthday':
        return '$nameさんの誕生日です。';
      case 'celebration':
        return '$nameさんが祝ってくれました。';
      default:
        return '新しい通知があります。';
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = _getMessage(notification['type'] as String, notification['name'] as String);
    final time = notification['time'] as String;
    final avatarUrl = notification['avatar'] as String;

    return Padding(
      // 行間を詰める
      padding: const EdgeInsets.symmetric(vertical: 6.0), 
      child: Row(
        // ★修正: 中央揃えに変更し、アイコンとテキストを垂直方向に揃える
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // アバター画像 (円形)
          ClipOval( 
            child: Image.network(
              avatarUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              // エラー時のフォールバック (例: アイコン)
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle, // フォールバックも円形に
                  ),
                  child: Icon(Icons.person, color: AppColors.textWhite),
                );
              },
            ),
          ), 
          SizedBox(width: 12),
          // 通知メッセージと時間
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$message $time',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}