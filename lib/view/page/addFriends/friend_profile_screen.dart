//PAGE:友達のprofile画面

//**MEMO
//友達追加リクエスト形式かどうか決めてなかったため、
//リクエスト押したら許可される前にカレンダーに誕生日が追加される挙動に(今のところ)
//なっていたので、【リクエスト】から【追加】にボタンのテキスト変えてます
// */
import 'package:candlecatch/view/components/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/database_service.dart';
import 'package:candlecatch/constants/colors.dart';
import '../src/calendar.dart';

class FriendProfileScreen extends StatefulWidget {
  final String friendUid;

  const FriendProfileScreen({super.key, required this.friendUid});

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  // リクエストが送信されたかどうかを管理するフラグ
  bool _isRequestSent = false;

  // 本来は前の画面から渡される友達のデータ
  final String friendUid = "friend_user_abc_123"; // 仮のID
  final String friendName = "そうた";
  final String friendImageUrl = "icon/img_7.jpg";
  final DateTime friendBirthday = DateTime(2026, 1, 20);

  Future<void> _sendRequest() async {
    // final String? currentUid = DatabaseService().currentUid;
    final String? currentUid = friendUid;

    // ログインチェック
    if (currentUid == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('エラー：ログインユーザーが見つかりません。')));
      }
      return;
    }

    setState(() {
      _isRequestSent = true;
    });

    // 3秒後に自動的に前の画面に戻る場合（オプション）
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) Navigator.pop(context);
    // });

    try {
      // DatabaseService を使用して Firestore に書き込み
      // 自分のカレンダー（celebrationsコレクション）に友達の誕生日を書き込む
      await DatabaseService().addFriendToMyCalendar(
        myUid: currentUid,
        friendUid: friendUid,
        friendName: friendName,
        photoUrl: friendImageUrl,
        birthday: friendBirthday,
      );
      // 成功したらSnackBarなどで通知（任意）
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('カレンダーに誕生日を追加しました！')));
      }
    } catch (e) {
      debugPrint('カレンダー登録エラー: $e');
      if (mounted) {
        setState(() => _isRequestSent = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.bt,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ),

            // 中央のプロフィールカード
            Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(friendImageUrl),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    // 名前
                    Text(
                      friendName,
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
                        onPressed: _isRequestSent ? null : _sendRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bt,
                          disabledBackgroundColor: Colors.grey[300], // 無効化時の色
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _isRequestSent ? '追加済み' : '友達を追加する',
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
            //TODOこの処理かsnackバーかどちらかに統一したい
            if (_isRequestSent)
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
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
                        '追加しました！',
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
    );
  }
}
