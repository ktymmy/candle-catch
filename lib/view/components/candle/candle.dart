import 'package:flutter/material.dart';
import '../../components/calender/cell.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({super.key});

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // カレンダーなので7列
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.8,
      ),
      itemCount: 35, // 7×5 のセル
      itemBuilder: (context, index) {
        return Cell(); // ← 各マスに Cell を表示
      },
    );
  }
}
