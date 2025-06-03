import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'user_info_input_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _handleGoogleLogin(BuildContext context) async {
    final authService = AuthService();
    final idToken = await authService.signInWithGoogle();

    if (idToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('구글 로그인 실패')),
      );
      return;
    }

    final result = await authService.authenticateWithServer(idToken);
    final location = result?['location'];
    final userId = result?['user_id'];

    if (userId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
    }

    if (location == '/home') {
      Navigator.pushNamed(context, '/home');
    } else if (location == '/users/signup') {
      Navigator.pushNamed(context, '/user_info_input_page1');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알 수 없는 응답')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // 로그인 타이틀
          Positioned(
            left: 24,
            top: 162,
            child: Text(
              '로그인',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          // 이메일 입력 필드
          Positioned(
            top: 262,
            left: 39,
            right: 39,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0x191A237E),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 비밀번호 입력 필드
          Positioned(
            top: 366,
            left: 39,
            right: 39,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '비밀번호',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0x191A237E),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 로그인 버튼
          Positioned(
            top: 531,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfoInputPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '로그인',
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

          // 소셜 로그인 아이콘들 (가운데 정렬)
          // 소셜 회원가입 버튼들 (아이콘만, 가운데 정렬)
          Positioned(
            top: 687,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google
                IconButton(
                  onPressed: () => _handleGoogleLogin(context),
                  icon: Image.asset('assets/login/google.png',
                      width: 36.8, height: 35),
                  tooltip: 'Google로 가입',
                ),
                const SizedBox(width: 50),
                // Kakao
                IconButton(
                  onPressed: () {
                    // 카카오 회원가입 로직
                  },
                  icon: Image.asset('assets/login/kakao.png',
                      width: 36.8, height: 35),
                  tooltip: 'Kakao로 가입',
                ),
                const SizedBox(width: 50),
                // Naver
                IconButton(
                  onPressed: () {
                    // 네이버 회원가입 로직
                  },
                  icon: Image.asset('assets/login/naver.png',
                      width: 36.8, height: 35),
                  tooltip: 'Naver로 가입',
                ),
              ],
            ),
          ),

          // 하단 인디케이터
          Positioned(
            bottom: 0,
            left: 130,
            child: Container(
              width: 134,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
