import 'package:flutter/material.dart';
import 'home_page.dart'; // 이후 서버로 데이터 전송 후 홈으로 이동한다고 가정

class UserInfoInputPage5 extends StatelessWidget {
  const UserInfoInputPage5({super.key});

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

          // 상단 네비게이션 바
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
                  Image.asset('assets/info/chatbot.png', width: 28),
                  const SizedBox(width: 10),
                  Image.asset('assets/info/schedule.png', width: 28),
                  const SizedBox(width: 10),
                  Image.asset('assets/info/profile.png', width: 28),
                ],
              ),
            ),
          ),

          // 진행 바
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  width: 300,
                  height: 8,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3, color: Color(0xFF1A237E)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 질문 텍스트
          const Positioned(
            left: 36,
            top: 170,
            child: Text(
              'Q. 일주일에 몇 번 운동하시나요?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 선택지 항목
          ..._buildOption(274, '1회', '가볍게 시작해보고 싶어요.'),
          ..._buildOption(365, '2~3회', '적당히 꾸준하게 운동하고 싶어요.'),
          ..._buildOption(453, '4~5회', '체계적인 루틴을 실천하고 있어요.'),
          ..._buildOption(542, '매일', '운동은 일상입니다.'),
          ..._buildOption(627, '정해진 횟수 없음', '상황에 맞게 자유롭게 운동해요.'),

          // 다음 버튼
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // 이 시점에서 user_id, JWT, form 데이터 모아서 API 전송할 수 있음
                  Navigator.pushNamed(context, '/home');
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
                    fontFamily: 'Pretendard',
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

  List<Widget> _buildOption(double top, String title, String desc) {
    return [
      Positioned(
        left: 11,
        top: top,
        child: Container(
          width: 369,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0x191A237E),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      Positioned(
        left: 39,
        top: top + 17,
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
        left: 41,
        top: top + 44,
        child: SizedBox(
          width: 296,
          child: Text(
            desc,
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: null,
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
