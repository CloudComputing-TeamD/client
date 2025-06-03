import 'package:flutter/material.dart';
import 'home_page.dart';

class UserInfoInputPage4 extends StatelessWidget {
  const UserInfoInputPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 시간 여백
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

          // 진행 바
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
            child: Text(
              'Q. 어떤 부위를 중점적으로 운동하고\n싶으신가요? (중복 선택 가능)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          ..._buildOption(
              274, '상체 (가슴, 등, 어깨 등)', '상체 근육 강화 및 균형 잡힌 체형을 만들고 싶어요.'),
          ..._buildOption(
              365, '하체 (허벅지, 엉덩이, 종아리 등)', '하체 근력을 향상시키고 다리 라인을 잡고 싶어요.'),
          ..._buildOption(453, '복부 (복근, 코어 등)', '뱃살을 줄이고 복부 근육을 단련하고 싶어요.'),
          ..._buildOption(542, '전신', '특정 부위보다는 전신 균형을 맞춰 운동하고 싶어요.'),
          ..._buildOption(627, '유산소 위주', '체중 감량과 체력 향상을 위한 운동을 하고 싶어요.'),

          // 다음 버튼
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user_info_input_page5');
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
