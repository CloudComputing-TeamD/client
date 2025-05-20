import 'package:flutter/material.dart';
import 'package:frontend/widgets/top_nav_bar.dart';

class RoutinePage extends StatefulWidget {
  final String? routineTitle;

  const RoutinePage({super.key, required this.routineTitle});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  List<Map<String, dynamic>> routineItems = [
    {
      'image': 'assets/routine/pulldown.png',
      'title': '글루트 킥 백(힙 익스텐션)',
      'sets': '5 세트 x 10 kg x 20 회',
      'isPinned': false,
    },
    {
      'image': 'assets/routine/lift.png',
      'title': '니 푸시 업',
      'sets': '5 세트 x 10 kg x 20 회',
      'isPinned': false,
    },
    {
      'image': 'assets/routine/lift.png',
      'title': '랫 풀다운',
      'sets': '5 세트 x 10 kg x 20 회',
      'isPinned': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.routineTitle == null) {
      return const Scaffold(
        body: Center(child: Text('루틴 정보를 불러올 수 없습니다')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),
          const Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: TopNavBar(assetPrefix: 'assets/routine'),
          ),
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.routineTitle!,
                        style: const TextStyle(
                          color: Color(0xFF2A291C),
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset('assets/routine/options.png',
                          width: 28, height: 28),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: routineItems.length,
                      itemBuilder: (context, index) {
                        final item = routineItems[index];
                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFFF3F3F3), width: 2),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xFFF3F3F3),
                                      blurRadius: 8,
                                      offset: Offset(4, 4)),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(item['image'],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: const TextStyle(
                                            color: Color(0xFF2B291D),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Pretendard',
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFF1A237E),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            item['sets'],
                                            style: const TextStyle(
                                              color: Color(0xFF1A237E),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Pretendard',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 12,
                              child: GestureDetector(
                                onTapDown: (details) async {
                                  final result = await showMenu<String>(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      details.globalPosition.dx,
                                      details.globalPosition.dy,
                                      0,
                                      0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: Colors.white,
                                    elevation: 4,
                                    items: const [
                                      PopupMenuItem(
                                          value: 'pin', child: Text('고정')),
                                      PopupMenuItem(
                                          value: 'delete', child: Text('삭제')),
                                    ],
                                  );

                                  if (result == 'pin') {
                                    setState(() {
                                      for (var i = 0;
                                          i < routineItems.length;
                                          i++) {
                                        routineItems[i]['isPinned'] =
                                            (i == index);
                                      }
                                    });
                                  } else if (result == 'delete') {
                                    setState(() {
                                      routineItems.removeAt(index);
                                    });
                                  }
                                },
                                child: Image.asset(
                                  item['isPinned']
                                      ? 'assets/home/check.png'
                                      : 'assets/home/dot.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 16, bottom: 32),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A237E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        '운동 시작하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
