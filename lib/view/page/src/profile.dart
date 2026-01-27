//PAGE:プロフィール画面 Navibar右下

import 'dart:convert';
import 'package:candlecatch/services/auth_service.dart';
import 'package:candlecatch/services/database_service.dart';
import 'package:candlecatch/view/page/birthdayMemory/candle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

///const
import 'package:candlecatch/constants/colors.dart';
import 'package:candlecatch/view/page/birthdayMemory/YearDetail.dart';

///components
import '../../components/button.dart';

///page
import 'package:candlecatch/view/page/birthdayMemory/candle.dart';
import './setting.dart';
import '../addFriends/my_qr_screen.dart';

// Profile 呼び出しの際に図鑑達成数取得
class Profile extends StatelessWidget {
  final String? uid;

  const Profile({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    // uidが渡されていればそれを使い、なければ現在ログイン中の自分のUIDを使う
    final String targetUid =
        uid ?? FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: targetUid.isEmpty
          ? const Center(child: Text("ログインが必要です"))
          : FutureBuilder<QuerySnapshot>(
              // targetUidを使ってFirestoreを検索
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('user_id', isEqualTo: targetUid)
                  .get(),
              builder: (context, snapshot) {
                // 読み込み中
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // エラーまたはデータが見つからない
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("ユーザーデータが見つかりません"));
                }

                // データの取り出し
                final userData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;

                final String name = userData['name'] ?? 'Guest';
                final String displayId = userData['display_id'] ?? 'no_id';

                // 誕生日の変換処理
                String birthdayStr = '----/--/--';
                final dynamic rawBirthday = userData['birthday'];

                if (rawBirthday is Timestamp) {
                  DateTime date = rawBirthday.toDate();
                  birthdayStr =
                      "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
                } else if (rawBirthday is String) {
                  birthdayStr = rawBirthday;
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _ProfileHeader(
                        name: name,
                        displayId: displayId,
                        birthday: birthdayStr,
                        uid: targetUid,
                      ),
                      // 必要に応じて達成率バーやカルーセルをここに追加
                      const SizedBox(height: 20),
                      const _AchievementBar(progress: 0.5, current: 180),
                      const SizedBox(height: 20),
                      const _StackedCarouselPage(),
                      const SizedBox(height: 200),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String displayId;
  final String birthday;
  final String uid;

  // 受け取り口
  const _ProfileHeader({
    required this.name,
    required this.displayId,
    required this.birthday,
    required this.uid,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.08,
        left: width * 0.05,
        right: width * 0.05,
      ),
      child: Column(
        children: [
          _buildTopBar(context, displayId),
          SizedBox(height: height * 0.03),
          _buildUserInfo(context, width, height),
        ],
      ),
    );
  }

  //topbar
  Widget _buildTopBar(BuildContext context, String displayId) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '@$displayId',
          style: TextStyle(
            fontSize: 30,
            fontFamily: "Corporate Logo Rounded Bold",
            color: AppColors.textBlack,
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopCircleButton(
              icon: Icons.qr_code_2,
              onTap: () {
                print('tap');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyQrScreen()),
                );
              },
            ),
            SizedBox(width: width * 0.03),
            TopCircleButton(
              icon: Icons.settings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('images/card1.JPEG'),
          backgroundColor: AppColors.textLightBlack,
        ),
        SizedBox(width: width * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.005),
            Text(
              birthday,
              style: const TextStyle(
                fontSize: 32,
                fontFamily: "Corporate Logo Rounded Bold",
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AchievementBar extends StatefulWidget {
  final double progress; // 進捗パーセント
  final int current; // 図鑑達成数

  const _AchievementBar({
    super.key,
    required this.progress,
    required this.current,
  }); //TODO: 図鑑達成率を渡す

  @override
  State<_AchievementBar> createState() => _AchievementBarState();
}

class _AchievementBarState extends State<_AchievementBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // グラデーション色をアニメーション
    _colorAnimation = ColorTween(
      begin: AppColors.gradientStart,
      end: AppColors.gradientEnd,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "図鑑達成率  ${widget.current} / 366",
          style: TextStyle(
            fontFamily: "Corporate Logo Rounded Bold",
            color: AppColors.textLightBlack,
            fontSize: 15, // TODO:フォントサイズレスポンシブ対応
          ),
        ),
        SizedBox(height: height * 0.006),
        Container(
          width: width * 0.4, // Barの全体の横幅
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  minHeight: height * 0.015, // Bar高さ
                  value: widget.progress, // Bar色つき横幅
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _colorAnimation.value ?? AppColors.gradientStart,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _StackedCarouselPage extends StatefulWidget {
  const _StackedCarouselPage({Key? key}) : super(key: key);

  @override
  _StackedCarouselPageState createState() => _StackedCarouselPageState();
}

class _StackedCarouselPageState extends State<_StackedCarouselPage> {
  final List<List<String>> cardImages = [
    ['images/card1.JPEG', '2022'],
    ['images/card1.JPEG', '2023'],
    ['images/card3.JPEG', '2024'],
    ['images/card4.JPG', '2025'],
  ];

  late PageController _pageController;
  double _currentPage = 0.0; // 現在のページ位置 (doubleで正確なスクロール位置を保持)

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6, // 中央のカードの表示領域 (60%)
      initialPage: 0,
      // initialPage: cardImages.length,
    );

    // ページ監視
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.45, // 画面の半分程度の高さに収める
      child: PageView.builder(
        controller: _pageController,
        itemCount: cardImages.length,
        itemBuilder: (context, index) {
          final double relativePosition = index - _currentPage;
          final String imagePath = cardImages[index][0];
          final String year = cardImages[index][1];

          //計算
          final double calculatedScale =
              1.0 - (relativePosition.abs() * 0.2); // 0.5だと小さくなりすぎたので0.2に調整
          final double finalScale = math.max(0.7, calculatedScale);

          final double calculatedOpacity = 1.0 - (relativePosition.abs() * 0.3);
          final double finalOpacity = math.max(0.0, calculatedOpacity);

          final double offsetY = relativePosition.abs() * 20;

          // _buildCard呼び出し
          return _buildCard(
            imagePath: imagePath,
            year: year,
            scale: finalScale,
            opacity: finalOpacity,
            offsetY: offsetY,
            relativePosition: relativePosition,
            isCurrentPage: (index == _currentPage.round()),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required String imagePath,
    required String year,
    required double scale,
    required double opacity,
    required double offsetY,
    required double relativePosition,
    required bool isCurrentPage,
  }) {
    final height = MediaQuery.of(context).size.height;
    Key? cardKey = isCurrentPage ? ValueKey('center_card_$imagePath') : null;

    final width = MediaQuery.of(context).size.width;

    final double calculatedScale = 1.0 - (relativePosition.abs() * 0.5);

    final double finalScale = math.max(0.7, calculatedScale);

    final double calculatedOpacity = 1.0 - (relativePosition.abs() * 0.3);
    final double finalOpacity = math.max(0.0, calculatedOpacity);

    final double offsetX = relativePosition * 0;

    final double currentOffsetY = relativePosition.abs() * 0;

    //     Key? cardKey = isCurrentPage
    //         ? ValueKey('center_card_$imagePath')
    //         : null; // add
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          key: cardKey,
          offset: Offset(0, offsetY * (relativePosition > 0 ? 1 : -1)),
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: Opacity(
              opacity: opacity,
              child: GestureDetector(
                onTap: () {
                  if (isCurrentPage) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            candle(year: year, imagePath: imagePath),
                      ),
                    );
                  } else {
                    _pageController.animateToPage(
                      _pageController.page!.round() + relativePosition.round(),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Hero(
                      tag: imagePath + year, // tagをユニークにするためyearを追加
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.textLightBlack,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isCurrentPage)
          Text(
            year,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Corporate Logo Rounded Bold",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textLightBlack,
            ),
          ),
      ],
    );
  }
}
