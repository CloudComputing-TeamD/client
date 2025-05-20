import 'package:flutter/material.dart';
import 'package:frontend/widgets/top_nav_bar.dart';
import 'home_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 상단 시간 여백
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),

          // 네비게이션 바 (로고 + 아이콘 대체)
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: TopNavBar(assetPrefix: 'assets/mypage'),
          ),

          // 프로필 이미지
          Positioned(
            left: 90,
            top: 200,
            child: Container(
              width: 213,
              height: 198,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/mypage/egg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 이름 입력 필드
          Positioned(
            left: 20,
            top: 371,
            child: SizedBox(
              width: 353,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '이름',
                  labelStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    color: Color(0xFF626161),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A237E)),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // 키 입력 필드
          Positioned(
            left: 20,
            top: 451,
            child: SizedBox(
              width: 353,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '키',
                  labelStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    color: Color(0xFF626161),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A237E)),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // 체중 입력 필드
          Positioned(
            left: 20,
            top: 531,
            child: SizedBox(
              width: 353,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '체중',
                  labelStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    color: Color(0xFF626161),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A237E)),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // 목표 체중 입력 필드
          Positioned(
            left: 20,
            top: 611,
            child: SizedBox(
              width: 353,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '목표 체중',
                  labelStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    color: Color(0xFF626161),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF1A237E)),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // 저장 버튼
          Positioned(
            bottom: 40,
            left: 32,
            right: 32,
            child: ElevatedButton(
              onPressed: () {
                // 저장 로직 또는 다음 페이지 이동
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '저장',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Pretendard',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
