//PAGE:バースデーカード一覧
//自分が誕生日の日に送られてくるカードをスワイプで閲覧するページ
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../../model/birthday_model.dart';
import '../birthdayCard/birthdayCard.dart';
import '../../../constants/colors.dart';

class BirthdaySwipePage extends StatefulWidget {
  const BirthdaySwipePage({super.key});

  @override
  State<BirthdaySwipePage> createState() => _BirthdaySwipePageState();
}

class _BirthdaySwipePageState extends State<BirthdaySwipePage> {
  late MatchEngine _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  // 仮データ
  final List<BirthdayCardModel> cards = [
    BirthdayCardModel(
      id: '1',
      senderName: 'TARO',
      message: '誕生日おめでとう！最高の一年にしてね🎉',
      imageUrl: 'https://picsum.photos/400/600?1',
    ),
    BirthdayCardModel(
      id: '2',
      senderName: 'HANAKO',
      message: '素敵な一年になりますように✨',
      imageUrl: 'https://picsum.photos/400/600?2',
    ),
    BirthdayCardModel(
      id: '3',
      senderName: 'JIRO',
      message: 'これからもよろしく！',
      imageUrl: 'https://picsum.photos/400/600?3',
    ),
  ];

  @override
  void initState() {
    super.initState();

    for (final card in cards) {
      _swipeItems.add(
        SwipeItem(
          content: card,

          // TODO:スワイプしたら相手にお礼の通知など送る場合ここ実装する！
          likeAction: () {
            debugPrint('りあくしょん');
          },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Birthday Cards'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Column(
        children: [
          Expanded(
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (context, index) {
                final BirthdayCardModel card = _swipeItems[index].content;
                return BirthdayCard(card: card);
              },
              onStackFinished: () {
                _showFinishedDialog(context);
              },

              upSwipeAllowed: false,
              fillSpace: true,
            ),
          ),
        ],
      ),
    );
  }

  void _showFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎂', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                const Text(
                  '全部見終わったよ！',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                //TODO: カウントの実装
                const Text('キャンドルが3本カウントされました🕯', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bt,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context, rootNavigator: true).pop();
                  },

                  child: const Text(
                    'とじる',
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
