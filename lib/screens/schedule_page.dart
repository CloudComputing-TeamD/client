import 'package:flutter/material.dart';
import 'package:frontend/screens/my_page2.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  void _showTodayWorkoutOverlay() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '오늘의 운동 루틴',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                ..._todayWorkoutItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            item['image'],
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              Text(
                                item['sets'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF1A237E),
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMay27WorkoutOverlay() {
    final List<Map<String, dynamic>> _may27WorkoutItems = [
      {
        'image': 'assets/schedule/pushup.png',
        'title': '푸쉬업',
        'sets': '3세트 x 20회',
      },
      {
        'image': 'assets/schedule/lunge.png',
        'title': '런지',
        'sets': '3세트 x 15회',
      },
      {
        'image': 'assets/schedule/jumping.png',
        'title': '점핑 잭',
        'sets': '4세트 x 15회',
      },
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '전신 유산소 루틴',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                ..._may27WorkoutItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            item['image'],
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              Text(
                                item['sets'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF1A237E),
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final List<DateTime> workoutDates = [
    DateTime.utc(2025, 6, 8),
  ];

  final List<Map<String, dynamic>> _todayWorkoutItems = [
    {
      'image': 'assets/schedule/bear.png',
      'title': '베어 크라울',
      'sets': '3 세트 x 20 회',
    },
    {
      'image': 'assets/schedule/mountain.png',
      'title': '마운틴 클라이머',
      'sets': '3 세트 x 30 회',
    },
    {
      'image': 'assets/schedule/jumping.png',
      'title': '점핑 잭',
      'sets': '4 세트 x 15 회',
    },
  ];

  final List<Map<String, dynamic>> _may27WorkoutItems = [
    {
      'image': 'assets/schedule/pushup.png',
      'title': '푸쉬업',
      'sets': '3세트 x 20회',
    },
    {
      'image': 'assets/schedule/lunge.png',
      'title': '런지',
      'sets': '3세트 x 15회',
    },
    {
      'image': 'assets/schedule/jumping.png',
      'title': '점핑 잭',
      'sets': '4세트 x 15회',
    },
  ];

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
                _buildTimeCard('오늘의 운동시간', '0:47'),
                _buildTimeCard('평균 운동 시간', '0:53'),
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
            child: CalendarGrid(
              year: year,
              month: month,
              onDateTap: (date) {
                if (date == DateTime.utc(2025, 5, 27)) {
                  _showMay27WorkoutOverlay();
                } else if (date == DateTime.utc(2025, 6, 8)) {
                  _showTodayWorkoutOverlay();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String title, String time) {
    return GestureDetector(
      onTap: title == '오늘의 운동시간' ? _showTodayWorkoutOverlay : null,
      child: Container(
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
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final void Function(DateTime)? onDateTap;
  final List<DateTime> workoutDates = [
    DateTime.utc(2025, 6, 8),
    DateTime.utc(2025, 6, 6),
    DateTime.utc(2025, 6, 4),
    DateTime.utc(2025, 6, 1),
    DateTime.utc(2025, 5, 29),
    DateTime.utc(2025, 5, 27),
  ];

  CalendarGrid({
    super.key,
    required this.year,
    required this.month,
    this.onDateTap,
  });

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

              final isWorkoutDay = day != null &&
                  workoutDates.any((d) =>
                      d.year == year && d.month == month && d.day == day);

              return SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: day != null
                      ? GestureDetector(
                          onTap: () {
                            if (onDateTap != null) {
                              onDateTap!(DateTime.utc(year, month, day));
                            }
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color:
                                  isWorkoutDay ? const Color(0xFF1A237E) : null,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$day',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  color: isWorkoutDay
                                      ? Colors.white
                                      : const Color(0xFF626161),
                                ),
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
