import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 認証
class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 現在ログインしているユーザのUIDを取得
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  // 「新規登録時」usersコレクションに基本プロフィールを作成
  Future<void> createNewUserData({
    required String uid,
    required String email,
    required String username,
    required String displayId,
    required DateTime birthday,
  }) async {
    return await _db.collection('users').doc(uid).set({
      'user_id': uid, // PK
      'display_id': displayId,
      'email': email,
      'name': username,
      'birthday': birthday,
      'created_at': FieldValue.serverTimestamp(), // 登録日時
      // その他の初期フィールドを設定
      'is_receive_encounter': true, // すれ違い祝福の受信設定
      'level_id': 1, // 現在のレベルID
    });
  }

  // 本人の記録の作成（アルバム・実績）
  // その年に受け取ったキャンドルの総数、メインとなる写真の管理
  Future<void> createYearlyBirthdayRecord({
    required String userId,
    required int year,
    required String photoUrl,
    required bool isPublic,
  }) async {
    // birthdaysに新しいドキュメントを作成
    await _db.collection('birthdays').add({
      'user_id': userId,
      'year': year,
      'photo_url': photoUrl, // 本気の一枚の画像url
      'candle_count': 0, // その年に祝われたキャンドルの数 (初期値0)
      'is_public': isPublic, // 公開/非公開設定
      'created_at': FieldValue.serverTimestamp(), // 登録日時
    });
  }

  // 「カレンダー表示」友達の誕生日を「自分のカレンダー」に予定として登録する
  // HOME画面のPageView（カレンダー）に友達のアイコンが表示される
  Future<void> addFriendToMyCalendar({
    required String myUid, // 自分のID
    required String friendUid, // 友達のID
    required String friendName, // 友達の名前
    required String photoUrl, // プロフィール画像
    required DateTime birthday, // 誕生日
  }) async {
    await _db.collection('celebrations').add({
      'receiver_id': myUid, // 表示対象者（自分）
      'target_friend_id': friendUid, // 誰の誕生日か
      'sender_name': friendName,
      'sender_image': photoUrl,
      'celebration_date': Timestamp.fromDate(birthday), // これでカレンダーの日にちが決まる
      'type': 'birthday_event', // 予定であることを示すフラグ
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  // 祝いイベントの作成（キャンドルを贈る処理）
  Future<void> createCelebration({
    required String receiverId,
    required String yearlyRecordId,
    required bool isEncounter,
    required Map<String, dynamic> candleData,
    required Map<String, dynamic> giftData,
    required Map<String, dynamic> messageData,
  }) async {
    final senderId = currentUid;
    if (senderId == null) {
      throw Exception("ログインユーザーが見つかりません。");
    }

    await _db.collection('celebrations').add({
      'receiver_id': receiverId, // FK
      'sender_id': senderId, // FK
      'yearly_record_id': yearlyRecordId,
      'is_encounter': isEncounter,
      'celebration_date': FieldValue.serverTimestamp(),
      'candle': candleData,
      'gift': giftData,
      'message': messageData,
    });
  }

  // 「カレンダー用」指定した「年・月」に合致する自分宛の全イベント（予定・お祝い）を取得
  Stream<List<Map<String, dynamic>>> streamMonthlyCelebrations(
    String myUid,
    int year,
    int month,
  ) {
    return _db
        .collection('celebrations')
        .where('receiver_id', isEqualTo: myUid) // 自分のIDに一致する予定だけ取得
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // ユーザーが受け取った祝いイベントのリストを取得（受信トレイ）
  Stream<List<Map<String, dynamic>>> streamReceivedCelebrations(String userId) {
    return _db
        .collection('celebrations')
        .where('receiver_id', isEqualTo: userId)
        .orderBy('celebration_date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {...doc.data(), 'celebration_id': doc.id})
              .toList(),
        );
  }
}
