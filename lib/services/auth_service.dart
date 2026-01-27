import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';

class AuthService {
  // FirebaseAuthの唯一のインスタンスを取得
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ログイン状態を監視するストリーム
  Stream<User?> get userChanges => _auth.authStateChanges();

  // サインアップ機能（AuthenticationとFirebaseへのデータ保存を統合）
  Future<String?> signUp(
    String email,
    String password,
    String username,
    String displayId,
    DateTime birthday,
  ) async {
    try {
      // ユーザ作成
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //  認証成功後 でデータを保存auth_service.dart でこの createNewUserData が正しく呼び出されているか確認すれば、認証とデータベース連携のバックエンド作業は完了
      if (userCredential.user != null) {
        await DatabaseService().createNewUserData(
          uid: userCredential.user!.uid, // Authenticationで作成されたUID
          email: email,
          username: username,
          displayId: displayId,
          birthday: birthday,
        );
      }

      return null; // 成功時はnullを返す
    } on FirebaseAuthException catch (e) {
      // Firebase認証のエラーをキャッチしてメッセージを返す
      return e.message;
    } catch (e) {
      // その他の予期せぬエラーをキャッチ
      return '予期せぬエラーが発生しました: $e';
    }
  }

  // ログイン機能
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      // Firebase認証のエラーをキャッチしてメッセージを返す
      return e.message;
    }
  }

  //ログアウト機能
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
