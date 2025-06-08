import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'dart:async';

class RoutinePage extends StatefulWidget {
  final String? routineTitle;

  const RoutinePage({super.key, required this.routineTitle});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> with RouteAware {
  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _setsControllers = [];
  List<TextEditingController> _weightControllers = [];
  List<TextEditingController> _repsControllers = [];

  bool _isEditMode = false;
  Timer? _timer;
  bool _isTimerVisible = false;
  bool _isTimerRunning = true;
  Duration _elapsedTime = Duration.zero;

  String? _selectedExercise;
  bool _showDropdown = false;

  final List<String> exerciseNames = [
    '크런치',
    '플랭크',
    '레그 레이즈',
    '바이시클 크런치',
    '마운틴 클라이머',
    '러시안 트위스트',
    '브이업',
    '플러터 킥',
    '랫 풀다운',
    '풀업',
  ];

  List<Map<String, dynamic>> routineItems = [
    {
      'image': 'assets/routine/9.png',
      'title': '크런치',
      'sets': '3 세트 x 10 kg x 15 회',
      'youtube': 'https://youtu.be/Xyd_fa5zoEU',
      'isPinned': false,
      'isChecked': false,
      'isEditing': false,
    },
    {
      'image': 'assets/routine/10.png',
      'title': '플랭크',
      'sets': '3 세트 x 0 kg x 15 회',
      'youtube': 'https://youtu.be/pSHjTRCQxIw',
      'isPinned': false,
      'isChecked': false,
      'isEditing': false,
    },
    {
      'image': 'assets/routine/11.png',
      'title': '레그 레이즈',
      'sets': '3 세트 x 5 kg x 20 회',
      'youtube': 'https://youtu.be/JB2oyawG9KI',
      'isPinned': false,
      'isChecked': false,
      'isEditing': false,
    },
    {
      'image': 'assets/routine/12.png',
      'title': '바이시클 크런치',
      'sets': '3 세트 x 5 kg x 20 회',
      'youtube': 'https://youtu.be/Iwyvozckjak',
      'isPinned': false,
      'isChecked': false,
      'isEditing': false,
    },
    {
      'image': 'assets/routine/22.png',
      'title': '마운틴 클라이머',
      'sets': '3 세트 x 5 kg x 20 회',
      'youtube': 'https://youtu.be/nmwgirgXLYM',
      'isPinned': false,
      'isChecked': false,
      'isEditing': false,
    },
  ];

  final List<Map<String, dynamic>> availableExercises = [
    {
      'title': '스쿼트',
      'image': 'assets/routine/squat.png',
      'sets': '3 세트 x 20 kg x 15 회',
      'youtube': 'https://youtu.be/aclHkVaku9U',
    },
    {
      'title': '크런치',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '플랭크',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '레그 레이즈',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '바이시클 크런치',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '마운틴 클라이머',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '러시안 트위스트',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '브이업',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '플러터 킥',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '랫 풀다운',
      'image': '',
      'sets': '',
      'youtube': '',
    },
    {
      'title': '풀업',
      'image': '',
      'sets': '',
      'youtube': '',
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void initState() {
    super.initState();

    // 기존 타이머 초기화 등
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isTimerRunning) {
        setState(() {
          _elapsedTime += const Duration(seconds: 1);
        });
      }
    });

    // 루틴 타이틀에 따른 운동 불러오기
    _initializeRoutineItems(widget.routineTitle);

    // Controller 초기화
    for (var item in routineItems) {
      _titleControllers.add(TextEditingController(text: item['title']));
      final setParts = (item['sets'] as String).split(RegExp(r'[^0-9]+'));
      _setsControllers.add(TextEditingController(text: setParts[0]));
      _weightControllers.add(TextEditingController(text: setParts[1]));
      _repsControllers.add(TextEditingController(text: setParts[2]));
    }
  }

  void _initializeRoutineItems(String? title) {
    if (title == null) return;

    if (title.contains("유산소")) {
      routineItems = [
        {
          'image': 'assets/routine/mountain.png',
          'title': '마운틴 클라이머',
          'sets': '3 세트 x 0 kg x 30 회',
          'youtube': 'https://youtu.be/nmwgirgXLYM',
          'isPinned': false,
          'isChecked': false,
          'isEditing': false,
        },
        {
          'image': 'assets/routine/bear.png',
          'title': '베어 크롤',
          'sets': '3 세트 x 0 kg x 20 회',
          'youtube': 'https://youtu.be/0FXaHQfJxYM',
          'isPinned': false,
          'isChecked': false,
          'isEditing': false,
        },
        {
          'image': 'assets/routine/jumping.png',
          'title': '점핑 잭',
          'sets': '4 세트 x 0 kg x 15 회',
          'youtube': 'https://youtu.be/c4DAnQ6DtF8',
          'isPinned': false,
          'isChecked': false,
          'isEditing': false,
        },
      ];
    }

    // 다른 루틴도 여기에 추가 가능
  }

  @override
  void dispose() {
    _timer?.cancel();
    routeObserver.unsubscribe(this);
    for (final c in _titleControllers) {
      c.dispose();
    }
    for (final c in _setsControllers) {
      c.dispose();
    }
    for (final c in _weightControllers) {
      c.dispose();
    }
    for (final c in _repsControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    // 다른 화면에서 돌아올 때 호출됨
    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.routineTitle == null) {
      return const Scaffold(
        body: Center(child: Text('루틴 정보를 불러올 수 없습니다')),
      );
    }

    Widget _buildEditableCard(int index) {
      final item = routineItems[index];
      final setParts =
          (item['sets'] as String).split(RegExp(r'[^0-9]+')); // 숫자만 추출
      final titleController = _titleControllers[index];
      final setsController = _setsControllers[index];
      final weightController = _weightControllers[index];
      final repsController = _repsControllers[index];

      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF1A237E), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 아이콘 (운동 그림)
            Image.asset(
              item['image'], // 또는 'assets/icons/exercise_icon.png'
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 12),

            // 중앙 입력 영역
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 운동 이름
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      hintText: '운동 이름',
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A237E)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1A237E)),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: TextField(
                          controller: setsController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '__',
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text('세트 x'),
                      SizedBox(
                        width: 32,
                        child: TextField(
                          controller: weightController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '__',
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text('kg x'),
                      SizedBox(
                        width: 32,
                        child: TextField(
                          controller: repsController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '__',
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text('회'),
                    ],
                  ),
                ],
              ),
            ),

            // 저장 버튼 (체크)
            IconButton(
              icon: const Icon(Icons.check, color: Color(0xFF1A237E)),
              onPressed: () {
                setState(() {
                  final updatedTitle = titleController.text;
                  final updatedSets = setsController.text;
                  final updatedWeight = weightController.text;
                  final updatedReps = repsController.text;

                  item['title'] = updatedTitle;
                  item['sets'] =
                      '$updatedSets 세트 x $updatedWeight kg x $updatedReps 회';
                  item['isEditing'] = false;

                  // Controller에도 업데이트된 텍스트를 반영해줘야 다음 build 때 유지됨
                  titleController.text = updatedTitle;
                  setsController.text = updatedSets;
                  weightController.text = updatedWeight;
                  repsController.text = updatedReps;
                });
              },
            ),
          ],
        ),
      );
    }

    Widget _buildNormalCard(int index) {
      final item = routineItems[index];
      return GestureDetector(
        onTap: () {
          if (_isEditMode) {
            setState(() {
              // 모든 아이템의 isEditing을 false로
              for (var i = 0; i < routineItems.length; i++) {
                routineItems[i]['isEditing'] = false;
              }
              routineItems[index]['isEditing'] = true;
            });
          }
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 204, 205, 225),
                border: Border.all(color: const Color(0xFFF3F3F3), width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFF3F3F3),
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final url = item['youtube'];
                      if (url != null) {
                        final uri = Uri.parse(url);
                        try {
                          final launched = await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                          if (!launched) {
                            print("❌ launchUrl 실패");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('YouTube를 열 수 없습니다.')),
                            );
                          } else {
                            print("✅ launchUrl 성공: $url");
                          }
                        } catch (e) {
                          print("🚨 예외 발생: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('YouTube 링크 실행 중 오류 발생')),
                          );
                        }
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        item['image'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            border:
                                Border.all(color: Color(0xFF1A237E), width: 1),
                            borderRadius: BorderRadius.circular(12),
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
              child: _isEditMode
                  ? Checkbox(
                      value: (item['isChecked'] ?? false) as bool,
                      onChanged: (bool? value) {
                        setState(() {
                          item['isChecked'] = value!;
                        });
                      },
                    )
                  : GestureDetector(
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
                            PopupMenuItem(value: 'pin', child: Text('고정')),
                            PopupMenuItem(value: 'delete', child: Text('삭제')),
                          ],
                        );

                        if (result == 'pin') {
                          setState(() {
                            for (var i = 0; i < routineItems.length; i++) {
                              routineItems[i]['isPinned'] = (i == index);
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
        ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          widget.routineTitle!,
                          style: const TextStyle(
                            color: Color(0xFF2A291C),
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: _isEditMode
                            ? [
                                // 삭제 아이콘
                                IconButton(
                                  icon: Image.asset(
                                    'assets/routine/delete.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      routineItems.removeWhere(
                                          (item) => item['isChecked'] == true);
                                    });
                                  },
                                ),

                                // 추가 아이콘
                                IconButton(
                                  icon: Image.asset(
                                    'assets/routine/plus.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showDropdown = !_showDropdown;
                                    });
                                  },
                                ),

                                // 완료 아이콘
                                IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Color(0xFF1A237E),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isEditMode = false;
                                      for (var item in routineItems) {
                                        item['isChecked'] = false;
                                        item['isEditing'] = false;
                                      }
                                    });
                                  },
                                ),
                              ]
                            : [
                                // 연필 아이콘
                                IconButton(
                                  icon: Image.asset(
                                    'assets/routine/options.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isEditMode = true;
                                    });
                                  },
                                ),
                              ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: routineItems.length,
                      itemBuilder: (context, index) {
                        final item = routineItems[index];

                        if (_isEditMode && item['isEditing'] == true) {
                          return _buildEditableCard(index); // 수정 상태일 때 보여줄 카드
                        } else {
                          return _buildNormalCard(index); // 평소 카드
                        }
                      },
                    ),
                  ),
                  if (_showDropdown)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECEBFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF1A237E), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 200), // 최대 높이 제한
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        height: 300,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              '운동 선택',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color(0xFF1A237E),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    availableExercises.length,
                                                itemBuilder: (context, index) {
                                                  final exercise =
                                                      availableExercises[index];
                                                  final isSelected =
                                                      _selectedExercise ==
                                                          exercise['title'];

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: isSelected
                                                          ? const Color(
                                                              0xFF1A237E)
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        exercise['title'],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: isSelected
                                                              ? Colors.white
                                                              : const Color(
                                                                  0xFF1A237E),
                                                          fontFamily:
                                                              'Pretendard',
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          _selectedExercise =
                                                              exercise['title'];
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xFF1A237E)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedExercise ?? '운동 선택',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF1A237E),
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down,
                                          color: Color(0xFF1A237E)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A237E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (_selectedExercise != null) {
                                  final selected =
                                      availableExercises.firstWhere(
                                    (e) => e['title'] == _selectedExercise,
                                  );

                                  setState(() {
                                    routineItems.add({
                                      'image': selected['image'],
                                      'title': selected['title'],
                                      'sets': selected['sets'],
                                      'youtube': selected['youtube'],
                                      'isPinned': false,
                                      'isChecked': false,
                                      'isEditing': false,
                                    });
                                    _showDropdown = false;
                                    _selectedExercise = null;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('운동이 루틴에 추가되었습니다!'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                '추가',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white, // 추가된 부분
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTimerVisible = true;
                        _elapsedTime = Duration.zero;
                        _isTimerRunning = true;
                      });
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
          ),
          if (_isTimerVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    // 타이머 시간 중앙 표시
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _elapsedTime
                                .toString()
                                .split('.')
                                .first
                                .padLeft(8, "0"),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 정지 버튼
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.25 - 42.5,
                      bottom: 100,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTimerRunning = !_isTimerRunning;
                          });
                        },
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A237E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isTimerRunning ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    // 종료 버튼
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.75 - 42.5,
                      bottom: 100,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTimerVisible = false;
                          });
                        },
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A237E),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 32,
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
