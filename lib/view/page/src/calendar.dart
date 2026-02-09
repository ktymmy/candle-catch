//PAGE:カレンダー(home)
import 'package:firebase_auth/firebase_auth.dart'; // timestampのため
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:candlecatch/services/database_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../constants/colors.dart';
import '../../components/button.dart';
import '../birthdayCard/birthday_swipe_page.dart';
import '../celebrate/confirmation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? _selectedDay;
  DateTime _focusedMonth = DateTime.now();
  late final PageController _pageController;
  final int _initialPage = 1200;
  final String _uid = FirebaseAuth.instance.currentUser?.uid ?? ''; // uidの取得

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _monthFromPage(int page) {
    final diff = page - _initialPage;
    return DateTime(DateTime.now().year, DateTime.now().month + diff);
  }

  bool _isToday(int day, DateTime month) {
    final now = DateTime.now();
    return now.year == _focusedMonth.year &&
        now.month == _focusedMonth.month &&
        now.day == day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),

                /// 月
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFA56B), Color(0xFFFFD36A)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            '${_focusedMonth.month}',
                            style: const TextStyle(
                              fontSize: 96,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// カレンダー
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        _focusedMonth = _monthFromPage(page);
                        _selectedDay = null;
                      });
                    },
                    itemBuilder: (context, pageIndex) {
                      final month = _monthFromPage(pageIndex);
                      final daysInMonth = DateUtils.getDaysInMonth(
                        month.year,
                        month.month,
                      );

                      // ここでFirestoreからその月のデータを取得
                      return StreamBuilder<List<Map<String, dynamic>>>(
                        stream: DatabaseService().streamMonthlyCelebrations(
                          _uid,
                          month.year,
                          month.month,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final List<Map<String, dynamic>> monthlyCelebrations =
                              snapshot.data ?? [];

                          return GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 6,
                                  childAspectRatio: 0.55,
                                ),
                            itemCount: daysInMonth,
                            itemBuilder: (context, index) {
                              final day = index + 1;

                              // その日のデータだけをフィルタリング
                              final dayDataList = monthlyCelebrations.where((
                                data,
                              ) {
                                // フィードが存在しているか、Timestamp型かを確認しながら取得
                                final dynamic timestamp =
                                    data['celebration_date'];
                                if (timestamp is Timestamp) {
                                  final date = timestamp.toDate();

                                  // 月・日が一致するかチェック（月をまたいだ表示を防ぐため）
                                  return date.month == month.month &&
                                      date.day == day;
                                }
                                return false;
                              }).toList();

                              return DayImageCard(
                                day: day,
                                celebrations: dayDataList, // 定義と名前を一致させた
                                isToday: _isToday(day, month),
                                isSelected: _selectedDay == day,
                                focusedMonth: month,
                                onTap: () {
                                  setState(() {
                                    _selectedDay = day;
                                  });
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // 右上のボタン
            Positioned(
              top: 12,
              right: 16,
              child: Row(
                children: [
                  TopCircleButton(
                    icon: Icons.cake,
                    onTap: () {
                      print('Cake Button Tapped!');
                      // QrScanScreenへ遷移
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BirthdaySwipePage(),
                        ),
                      );
                      print('tap');
                      //TODO: 誕生日一覧
                    },
                  ),
                  const SizedBox(width: 10),
                  TopCircleButton(
                    icon: Icons.notifications,
                    onTap: () {
                      print('tap');

                      // TODO:通知
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// セル
class DayImageCard extends StatefulWidget {
  final int day;
  final List<Map<String, dynamic>> celebrations;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;
  final DateTime focusedMonth;

  const DayImageCard({
    super.key,
    required this.day,
    required this.celebrations,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
    required this.focusedMonth,
  });

  @override
  State<DayImageCard> createState() => _DayImageCardState();
}

class _DayImageCardState extends State<DayImageCard> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startTimer();
  }

  void _startTimer() {
    // 内部でも widget.celebrations を参照
    if (widget.celebrations.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (!mounted) return;
        _index = (_index + 1) % widget.celebrations.length;
        _controller.animateToPage(
          _index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _showBirthdaySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          initialChildSize: 0.4,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        // color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  /// タイトル
                  Text(
                    '${widget.focusedMonth.month}/${widget.day}の誕生日',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// 誕生日データがない場合
                  if (widget.celebrations.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'なし',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...widget.celebrations.map(
                      (data) => Card(
                        color: Colors.white,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          //TODO: 画像表示
                          leading: const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFFFE0B2),
                            child: Icon(Icons.person, color: Colors.brown),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data['sender_name'] ?? 'なまえ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Expanded(
                                child: BrandGradientButton(
                                  text: '祝う',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const GiftConfirmPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _showBirthdaySheet(); // ボトムシート表示
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isToday ? const Color(0xFFFFE0B2) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: widget.isSelected
              ? Border.all(color: const Color(0xFFFFE0B2), width: 2)
              : null,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: [
            const SizedBox(height: 6),

            /// 日付
            Text(
              '${widget.day}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Expanded(
              child: widget.celebrations.isNotEmpty
                  ? PageView.builder(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.celebrations.length,
                      itemBuilder: (context, i) {
                        final data = widget.celebrations[i];
                        final imageUrl =
                            data['sender_image']; // Firestoreのフィールド名

                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200], // 画像がないときの背景色
                                  image:
                                      (imageUrl != null && imageUrl.isNotEmpty)
                                      ? DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit
                                              .cover, // 画像をContainerいっぱいにフィットさせる
                                        )
                                      : null,
                                ),
                                child: (imageUrl == null || imageUrl.isEmpty)
                                    ? const Icon(
                                        Icons.cake,
                                        color: Colors.orangeAccent,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                data['sender_name'] ?? 'なまえ',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
