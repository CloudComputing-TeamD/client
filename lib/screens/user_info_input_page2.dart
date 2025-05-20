import 'package:flutter/material.dart';
import 'user_info_input_page3.dart';

class UserInfoInputPage2 extends StatelessWidget {
  const UserInfoInputPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 상단 시간 공간만 유지
          // 상단 시간 여백
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
                  // 뒤로가기 버튼 (page2에만 존재)
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

          // 상단 하이라이트 진행 바
          Positioned(
            top: 124, // 네비게이션 바와 딱 붙도록 설정
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Container(
                    width: 120,
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
            left: 33,
            top: 173,
            child: SizedBox(
              width: 338,
              height: 40,
              child: Text(
                'Q. 현재 운동 수준은 어느 정도인가요?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // 운동 선택 카드 4개
          ..._buildOptionBlock(
            top: 282,
            title: '운동을 거의 하지 않음',
            subtitle: '일상생활 외에 별도의 운동을 해본 경험이 없습니다.',
          ),
          ..._buildOptionBlock(
            top: 384,
            title: '가볍게 활동 중',
            subtitle: '가끔 걷기나 스트레칭 정도의 가벼운 활동을 합니다.',
          ),
          ..._buildOptionBlock(
            top: 486,
            title: '규칙적인 운동 중',
            subtitle: '주 2~3회, 일정한 루틴으로 운동을 진행하고 있습니다.',
          ),
          ..._buildOptionBlock(
            top: 588,
            title: '고강도/체계적 운동 중',
            subtitle: '주 4회 이상 체계적인 운동을 실천하고 있습니다.',
          ),
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
                      builder: (context) => const UserInfoInputPage3(),
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

  List<Widget> _buildOptionBlock({
    required double top,
    required String title,
    required String subtitle,
  }) {
    return [
      Positioned(
        left: 12,
        top: top,
        child: Container(
          width: 369,
          height: 86,
          decoration: BoxDecoration(
            color: const Color(0x191A237E),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      Positioned(
        left: 36,
        top: top + 22,
        child: SizedBox(
          width: 325,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      Positioned(
        left: 38,
        top: top + 56,
        child: SizedBox(
          width: 296,
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ];
  }
}
