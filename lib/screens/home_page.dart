import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'routine_page.dart';

class HomePage extends StatefulWidget {
  final UserData userData;
  final Map<String, dynamic>? newRoutine;

  const HomePage({
    super.key,
    required this.userData,
    this.newRoutine,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = '최근';
  int? _editingRoutineId;
  bool _isDeletingTags = false;

  late List<Map<String, dynamic>> routines;

  @override
  void initState() {
    super.initState();

    final user = widget.userData;

    routines = [
      {
        "id": 1,
        "title": "체중 감량 루틴",
        "tags": ["유산소", "중급", "기초"],
        "isPinned": true,
      },
      {
        "id": 2,
        "title": "전신 유산소 루틴",
        "tags": ["전신", "유산소", "중급"],
        "isPinned": false,
      },
      {
        "id": 3,
        "title": "고강도 인터벌 트레이닝",
        "tags": ["HIIT", "중급", "유산소"],
        "isPinned": false,
      },
      {
        "id": 4,
        "title": "홈트 루틴",
        "tags": ["유산소", "기초", "집에서"],
        "isPinned": false,
      },
    ];

    if (widget.newRoutine != null) {
      routines.add(widget.newRoutine!);
    }
  }

  String _generateRoutineTitle(UserData user) {
    final goal = user.goal ?? '';
    if (goal.contains('체중')) return '체중 감량 루틴';
    if (goal.contains('근육')) return '근성장 루틴';
    if (goal.contains('건강')) return '건강 관리 루틴';
    return '맞춤형 루틴';
  }

  List<String> _generateTags(UserData user) {
    final level = user.workoutLevel?.toLowerCase() ?? '';
    final parts = user.targetParts ?? [];

    final tags = <String>[];

    if (level.contains('beginner')) tags.add('기초');
    if (level.contains('intermediate')) tags.add('중급');
    if (level.contains('advanced')) tags.add('고급');

    // 최대 2개까지 주요 부위 추가
    tags.insertAll(0, parts.take(2).toList());

    return tags;
  }

  void _showAddTagDialog(int routineId) {
    List<String> tagOptions = [
      "고급",
      "중급",
      "초급",
      "유산소",
      "전신",
      "복부",
      "복근",
      "코어",
      "하체",
      "허벅지",
      "엉덩이",
      "종아리",
      "상체",
      "가슴",
      "등",
      "어깨"
    ];

    String? selectedTag;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "태그 선택",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: tagOptions.length,
                    itemBuilder: (context, index) {
                      final tag = tagOptions[index];
                      return ListTile(
                        title: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: selectedTag == tag
                            ? const Icon(Icons.check_circle,
                                color: Color(0xFF1A237E))
                            : const Icon(Icons.circle_outlined,
                                color: Colors.grey),
                        onTap: () {
                          setState(() => selectedTag = tag);
                          Navigator.of(context).pop(); // 선택 즉시 닫기
                          if (selectedTag != null) {
                            final index = routines
                                .indexWhere((r) => r['id'] == routineId);
                            if (index != -1 &&
                                !routines[index]['tags']
                                    .contains(selectedTag)) {
                              setState(() {
                                routines[index]['tags'].add(selectedTag);
                              });
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("닫기"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("✅ HomePage 도착");
    print("📌 이메일: ${widget.userData.email}");
    print("📌 토큰: ${widget.userData.token}");
    print("📌 목표: ${widget.userData.goal}");
    print("📌 운동 레벨: ${widget.userData.workoutLevel}");
    print("📌 타겟 부위: ${widget.userData.targetParts}");
    print("📌 주당 횟수: ${widget.userData.frequency}");
    print("📌 성별: ${widget.userData.gender}");
    print("📌 키: ${widget.userData.height}");
    print("📌 몸무게: ${widget.userData.weight}");
    print("📌 생년월일: ${widget.userData.birthDate}");

    final sortedRoutines = [...routines]
      ..sort((a, b) => (b['isPinned'] ? 1 : 0) - (a['isPinned'] ? 1 : 0));

    return GestureDetector(
      onTap: () => setState(() => _editingRoutineId = null),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const Positioned(
                left: 40, top: 20, child: SizedBox(width: 60, height: 24)),
            Positioned(
              top: 44,
              left: 0,
              right: 0,
              child: TopNavBar(
                assetPrefix: 'assets/home',
                userData: widget.userData,
              ),
            ),
            Positioned(
              top: 124,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: const EdgeInsets.only(top: 16, bottom: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '내 루틴',
                          style: TextStyle(
                            color: Color(0xFF2A291C),
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              final newId = routines.isNotEmpty
                                  ? routines.last['id'] + 1
                                  : 1;
                              routines.add({
                                "id": newId,
                                "title": "새 루틴$newId",
                                "tags": ["새 태그"],
                                "isPinned": false,
                              });
                            });
                          },
                          child: Image.asset('assets/home/add.png',
                              width: 28, height: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: PopupMenuButton<String>(
                        onSelected: (value) =>
                            setState(() => _selectedFilter = value),
                        offset: const Offset(0, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        elevation: 4,
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: '최근', child: Text('최근')),
                          PopupMenuItem(value: '일주일', child: Text('일주일')),
                          PopupMenuItem(value: '한달', child: Text('한달')),
                        ],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedFilter,
                                style: const TextStyle(
                                    color: Color(0xFF6C6C72),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_drop_down,
                                color: Color(0xFF6C6C72), size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...sortedRoutines.map((routine) {
                      final isEditing = _editingRoutineId == routine['id'];
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/routine',
                                arguments: routine['title'],
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
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
                                      offset: Offset(4, 4))
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/home/lift.png',
                                      width: 40, height: 40, fit: BoxFit.cover),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(routine['title'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Pretendard',
                                                color: Color(0xFF2B291D))),
                                        if (routine['isPinned'])
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 4),
                                            height: 2,
                                            color: const Color(0xFF1A237E),
                                            // 텍스트 길이에 맞게 자동 너비 설정
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                final titleLength =
                                                    routine['title']
                                                        .toString()
                                                        .length;
                                                return SizedBox(
                                                    width: titleLength *
                                                        16.0); // 글자당 12px 정도 할당
                                              },
                                            ),
                                          ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          children: [
                                            ...routine['tags']
                                                .map<Widget>((tag) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x991A237E),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(tag,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Pretendard')),
                                                    if (isEditing &&
                                                        _isDeletingTags)
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() =>
                                                              routine['tags']
                                                                  .remove(tag));
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Icon(
                                                              Icons.close,
                                                              size: 14,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            if (isEditing && !_isDeletingTags)
                                              GestureDetector(
                                                onTap: () => _showAddTagDialog(
                                                    routine['id']),
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFF1A237E),
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(Icons.add,
                                                      color: Colors.white,
                                                      size: 18),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                      0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: Colors.white,
                                  elevation: 4,
                                  items: const [
                                    PopupMenuItem(
                                        value: 'pin', child: Text('고정')),
                                    PopupMenuItem(
                                        value: 'edit', child: Text('수정')),
                                    PopupMenuItem(
                                        value: 'delete', child: Text('삭제')),
                                  ],
                                );

                                if (result == 'pin') {
                                  setState(() {
                                    for (int i = 0; i < routines.length; i++) {
                                      routines[i]['isPinned'] =
                                          (routines[i]['id'] == routine['id']);
                                    }
                                  });
                                } else if (result == 'edit') {
                                  setState(() {
                                    _editingRoutineId = routine['id'];
                                    _isDeletingTags = false; // 수정 모드
                                  });
                                } else if (result == 'delete') {
                                  setState(() {
                                    routines.removeWhere(
                                        (r) => r['id'] == routine['id']);
                                    if (_editingRoutineId == routine['id']) {
                                      _editingRoutineId = null;
                                      _isDeletingTags = false;
                                    }
                                  });
                                }
                              },
                              child: Image.asset(
                                routine['isPinned']
                                    ? 'assets/home/check.png'
                                    : 'assets/home/dot.png',
                                width: 28,
                                height: 28,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
