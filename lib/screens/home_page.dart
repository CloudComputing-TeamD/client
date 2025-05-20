import 'package:flutter/material.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'routine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = '최근';
  int? _editingRoutineId;

  List<Map<String, dynamic>> routines = [
    {
      "id": 1,
      "title": "루틴 1",
      "tags": ["어깨", "삼두"],
      "isPinned": false,
    },
    {
      "id": 2,
      "title": "루틴 2",
      "tags": ["가슴", "이두"],
      "isPinned": false,
    },
    {
      "id": 3,
      "title": "루틴 3",
      "tags": ["하체"],
      "isPinned": true,
    },
  ];

  void _showAddTagDialog(int routineId) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("태그 추가"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "예: 복근"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final index = routines.indexWhere((r) => r['id'] == routineId);
                if (index != -1 && controller.text.trim().isNotEmpty) {
                  routines[index]['tags'].add(controller.text.trim());
                }
              });
              Navigator.pop(context);
            },
            child: const Text("추가"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            const Positioned(
              top: 44,
              left: 0,
              right: 0,
              child: TopNavBar(assetPrefix: 'assets/home'),
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
                                "title": "루틴 $newId",
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
                                              width: 40,
                                              color: Color(0xFF1A237E)),
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
                                                    if (isEditing)
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
                                            if (isEditing)
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
                            top: 40, // 중간 높이로 조정
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
                                  setState(
                                      () => _editingRoutineId = routine['id']);
                                } else if (result == 'delete') {
                                  setState(() => routines.removeWhere(
                                      (r) => r['id'] == routine['id']));
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
