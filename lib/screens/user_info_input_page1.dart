import 'package:flutter/material.dart';
import 'user_info_input_page2.dart';
import 'user_info_input_page1_5.dart';
import '../models/user_data.dart';

class UserInfoInputPage extends StatelessWidget {
  final UserData userData;

  const UserInfoInputPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as UserData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 상단 여백
          Positioned(
            left: 40,
            top: 20,
            child: SizedBox(
              width: 60,
              height: 24, // 기존 텍스트 높이 기준
            ),
          ),
          // 네비게이션 바
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Color(0xFFBFBFC4),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Image.asset('assets/info/logo.png', width: 60), // 좌측 로고
                  Spacer(),
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
          // 상단 하이라이트 바
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 말풍선 배경
          Positioned(
            left: 13,
            top: 170, // 아래로 이동
            child: Container(
              width: 369,
              height: 155.4,
              decoration: BoxDecoration(
                color: const Color(0x191A237E),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),

// 공룡 인사 문구
          const Positioned(
            left: 28.5,
            top: 191.6, // 아래로 이동
            child: SizedBox(
              width: 338,
              height: 76.2,
              child: Text(
                '안녕하세요! 저는 여러분의\nAI 피트니스 코치, 공룡이에요 💪',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

// 설명 문구
          const Positioned(
            left: 28.5,
            top: 256.4, // 아래로 이동
            child: SizedBox(
              width: 319,
              height: 87.6,
              child: Text(
                '회원님의 몸 상태와 운동 스타일에 꼭 맞는 루틴을 추천드릴게요.\n먼저 몇 가지 간단한 질문부터 시작해볼까요?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // 중간 배너 이미지
          Positioned(
            top: 370, // 아래로 이동
            left: 17,
            child: Container(
              width: 376.5,
              height: 251,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/info/dinor.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 운동 시작하기 버튼
          Positioned(
            bottom: 40,
            left: 28,
            right: 28,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/user_info_input_page1_5',
                  arguments: userData,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A237E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
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
    );
  }
}
