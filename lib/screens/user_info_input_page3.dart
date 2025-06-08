import 'package:flutter/material.dart';
import 'user_info_input_page4.dart';
import '../models/user_data.dart';

class UserInfoInputPage3 extends StatefulWidget {
  final UserData userData;

  const UserInfoInputPage3({super.key, required this.userData});

  @override
  State<UserInfoInputPage3> createState() => _UserInfoInputPage3State();
}

class _UserInfoInputPage3State extends State<UserInfoInputPage3> {
  String _selectedGoal = '';

  void _onSelect(String goal) {
    setState(() {
      _selectedGoal = goal;
      widget.userData.goal = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0xFFBFBFC4)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 24, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Image.asset('assets/info/logo.png', width: 60),
                  const Spacer(),
                  Image.asset('assets/info/chatbot.png', width: 28, height: 28),
                  const SizedBox(width: 10),
                  Image.asset('assets/info/schedule.png',
                      width: 28, height: 28),
                  const SizedBox(width: 10),
                  Image.asset('assets/info/profile.png', width: 28, height: 28),
                ],
              ),
            ),
          ),

          // 상단 파란 진행 바
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Container(
                    width: 240,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 3, color: Color(0xFF1A237E)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 질문 텍스트
          const Positioned(
            left: 36,
            top: 170,
            child: SizedBox(
              width: 338,
              height: 41,
              child: Text(
                'Q. 어떤 목표로 운동을 시작하시나요?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // 선택지 항목들
          ..._buildOption(
              top: 274, title: '체중 감량', desc: '지방을 줄이고 몸을 가볍게 만들고 싶어요.'),
          ..._buildOption(
              top: 365, title: '근력 향상', desc: '근육량을 늘리고 강한 체력을 기르고 싶어요.'),
          ..._buildOption(
              top: 453,
              title: '체형 개선 / 라인 정리',
              desc: '몸의 균형을 잡고 보기 좋게 다듬고 싶어요.'),
          ..._buildOption(
              top: 542, title: '운동 습관 형성', desc: '규칙적으로 운동하는 습관을 만들고 싶어요.'),
          ..._buildOption(
              top: 627,
              title: '체력 회복/건강 증진',
              desc: '쉽게 피로해지거나 움직이기 힘든 몸을 회복하고 싶어요.'),

          // 다음 버튼
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserInfoInputPage4(userData: widget.userData),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 128, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOption({
    required double top,
    required String title,
    required String desc,
  }) {
    final isSelected = _selectedGoal == title;
    return [
      Positioned(
        left: 11,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onSelect(title),
            borderRadius: BorderRadius.circular(40),
            splashColor: Colors.blue.withOpacity(0.2),
            highlightColor: Colors.blue.withOpacity(0.1),
            child: Container(
              width: 369,
              height: 70,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1A237E)
                    : const Color(0x191A237E),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.only(left: 24, right: 24, top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
