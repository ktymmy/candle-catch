import 'package:flutter/material.dart';
import 'package:candlecatch/constants/colors.dart';
import 'package:candlecatch/view/components/button.dart';
import 'package:candlecatch/view/components/form.dart';
import 'package:candlecatch/services/auth_service.dart';
import 'package:candlecatch/view/page/src/calendar.dart';
import 'package:candlecatch/view/page/navibar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  // 入力を管理するためのコントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 処理中（くるくる）を表示するためのフラグ
  bool _isLoading = false;

  @override
  void dispose() {
    // 画面が閉じられたらメモリを解放する
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                const Text(
                  'ログイン',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Corporate Logo Rounded Bold",
                  ),
                ),
                SizedBox(height: height * 0.1),

                // メールアドレス入力
                CustomTextField(
                  controller: _emailController,
                  labelText: 'メールアドレス',
                  hintText: 'メールアドレスを入力してください',
                  obscureText: false,
                ),
                SizedBox(height: height * 0.05),

                // パスワード入力
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'パスワード',
                  hintText: 'パスワードを入力してください',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // パスワード再設定リンク
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: パスワード再設定画面への遷移ロジック
                    },
                    child: Text(
                      'パスワードを忘れた場合',
                      style: TextStyle(
                        color: AppColors.textBlack.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.12),

                // ログインボタン or ローディング
                _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textBlack,
                        ),
                      )
                    : BrandGradientButton(
                        text: 'ログイン',
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('メールアドレスとパスワードを入力してください'),
                              ),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          String? result = await AuthService().signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          if (!context.mounted) return;
                          setState(() => _isLoading = false);

                          if (result == null) {
                            // 成功時
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('ログインに成功しました')),
                            );
                            // ホーム画面への遷移（必要に応じてコメントを外してください）
                            // Navigator.pushReplacementNamed(context, '/home');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Navibar(),
                              ),
                              (route) => false,
                            );
                          } else {
                            // 失敗時
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(result)));
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
