// PAGE: キャンドルをテーブルに載せた状態のコンポーネント
import 'dart:math';
import 'package:flutter/material.dart';
import './candle.dart';
import '../userInfo.dart';
import '../../page/src/candleInfo.dart';

class CandleTable extends StatefulWidget {
  final List<String> items = ["A", "B", "C", "D", "E", "F"];

  CandleTable({Key? key}) : super(key: key);

  @override
  CandleTableState createState() => CandleTableState();
}

class CandleTableState extends State<CandleTable> {
  double angle = 0;
  double sensitivity = 0.01;

  @override
  Widget build(BuildContext context) {
    final radius = 140.0;

    final List<_CircleItemData> itemData = List.generate(widget.items.length, (
      i,
    ) {
      final double unitAngle = (2 * pi) / widget.items.length;
      final double currentAngle = unitAngle * i + angle;
      final double x = radius * cos(currentAngle);
      final double y = radius * sin(currentAngle);

      final double depth = (y + radius) / (2 * radius);
      final double scale = 0.6 + depth * 0.4;
      final double opacity = 0.5 + depth * 0.5;

      return _CircleItemData(
        index: i,
        x: x,
        y: y,
        depth: depth,
        scale: scale,
        opacity: opacity,
      );
    });

    itemData.sort((a, b) => a.depth.compareTo(b.depth));

    return Container(
      padding: const EdgeInsets.only(bottom: 60),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            angle += details.delta.dx * sensitivity;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (final data in itemData)
              Transform.translate(
                offset: Offset(data.x, data.y * 0.4),
                child: Transform.scale(
                  scale: data.scale,
                  child: Opacity(
                    opacity: data.opacity,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Candleinfo(
                                  giverName: "ちゃんみ",
                                  giverImageUrl: "assets/images/sample.png",
                                ),
                              ),
                            );
                          },
                          child: Candle(),
                        ),

                        Positioned(
                          bottom: 30,
                          child: UserInfoColumn(
                            img: "icon/icon${data.index + 1}.png",
                            heights: 80,
                            widths: 60,
                          ),
                        ),
                      ],
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

// 🔽 各要素の計算済み情報を保持
class _CircleItemData {
  final int index;
  final double x;
  final double y;
  final double depth;
  final double scale;
  final double opacity;

  _CircleItemData({
    required this.index,
    required this.x,
    required this.y,
    required this.depth,
    required this.scale,
    required this.opacity,
  });
}
