//ユーザーアイコンと名前

import 'package:flutter/material.dart';
/**
  TODO:サイズ調整する
 */

/// ICONのみ表示
class UserIcon extends StatelessWidget {
  final String img;

  const UserIcon({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
    );
  }
}

//縦並び
class UserInfoColumn extends StatelessWidget {
  final String img;
  final double? heights;
  final double? widths;
  const UserInfoColumn({
    super.key,
    this.img = "icon/icon1.png",
    this.heights,
    this.widths,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: heights,
      width: widths,
      child: Column(
        children: [
          Image.asset(img),
          Text(
            '片山美結',
            style: TextStyle(fontSize: 9, overflow: TextOverflow.visible),
          ),
        ],
      ),
    );
  }
}

//横並び
class UserInfoRow extends StatelessWidget {
  final String img;
  const UserInfoRow({super.key, this.img = "icon/icon1.png"});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(img),
        Text('UserName', style: TextStyle()),
      ],
    );
  }
}
