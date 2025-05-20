import 'package:flutter/material.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final year = _focusedDay.year;
    final month = _focusedDay.month;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),

          // 네비게이션 바
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: TopNavBar(assetPrefix: 'assets/home'),
          ),

          Positioned(
            top: 160,
            left: 23,
            right: 23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeCard('오늘의 운동시간', '0:56'),
                _buildTimeCard('평균 운동 시간', '0:59'),
              ],
            ),
          ),

          // 달력 상단 타이틀과 화살표
          Positioned(
            top: 492,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat('yyyy년 M월').format(_focusedDay),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard',
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month + 1);
                    });
                  },
                ),
              ],
            ),
          ),

          // 요일 헤더
          Positioned(
            top: 540,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['일', '월', '화', '수', '목', '금', '토']
                  .map((day) => Text(
                        day,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF626161),
                          fontFamily: 'Pretendard',
                        ),
                      ))
                  .toList(),
            ),
          ),

          // 실제 달력 그리드
          Positioned(
            top: 552,
            left: 0,
            right: 0,
            child: CalendarGrid(year: year, month: month),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String title, String time) {
    return Container(
      width: 156,
      height: 285,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x991A237E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 24),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              fontFamily: 'Pretendard',
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final int year;
  final int month;

  const CalendarGrid({super.key, required this.year, required this.month});

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7; // 일요일 시작
    final today = DateTime.now();

    final totalCells = ((startWeekday + daysInMonth) / 7).ceil() * 7;

    return Column(
      children: List.generate((totalCells / 7).ceil(), (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (col) {
              final index = row * 7 + col;
              final day =
                  index >= startWeekday && index < startWeekday + daysInMonth
                      ? index - startWeekday + 1
                      : null;

              final isToday = day != null &&
                  today.year == year &&
                  today.month == month &&
                  today.day == day;

              return SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: day != null
                      ? Container(
                          width: 28,
                          height: 28,
                          decoration: isToday
                              ? const BoxDecoration(
                                  color: Color(0x661A237E),
                                  shape: BoxShape.circle,
                                )
                              : null,
                          child: Center(
                            child: Text(
                              '$day',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF626161),
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
