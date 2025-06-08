import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _handleGoogleLogin(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('구글 로그인'),
        content: const Text('Google 계정으로 로그인하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('확인'),
          ),
        ],
      ),
    );

    if (result != true) return; // 취소 누르면 아무것도 안 함

    // 2. 로그인 처리 (AuthService 호출)
    final authService = AuthService();
    final success = await authService.signInWithGoogle();

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 실패: 서버 인증에 실패했습니다.')),
      );
      return;
    }

    // ✅ 2. 이미 가입된 사용자라고 가정하고 더미 데이터 전달
    final userData = UserData(
      id: 'user123',
      token: 'fake-token-123',
      email: 'example@gmail.com',
      name: '홍길동',
      goal: '체중 감량',
      workoutLevel: 'intermediate',
      targetParts: ['하체', '복부'],
      frequency: 3,
      gender: '남성',
      height: 175,
      weight: 70,
    );

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: userData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 상단 로고 (크기 키우고 위치 조정)
          const Positioned(
            top: 44, // 루틴 페이지의 기준과 맞춤
            left: 16,
            child: SizedBox(
              width: 64,
              height: 64,
              child: Image(
                image: AssetImage('assets/login/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

// 파란 하단 라인 (로고 하단에 위치)
          const Positioned(
            top: 108, // 44(top) + 64(height) = 108
            left: 0,
            right: 0,
            child: Divider(
              thickness: 1,
              height: 1,
              color: Color(0xFF1A237E),
            ),
          ),

          // 로그인 타이틀
          const Positioned(
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
          // 이메일 입력 필드 (비활성 상태)
          const Positioned(
            top: 262,
            left: 39,
            right: 39,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이메일',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
                SizedBox(height: 8),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0x191A237E),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 비밀번호 입력 필드 (비활성 상태)
          const Positioned(
            top: 366,
            left: 39,
            right: 39,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '비밀번호',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
                SizedBox(height: 8),
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0x191A237E),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 로그인 버튼 (비활성 상태)
          Positioned(
            top: 531,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {}, // 임시 클릭 가능하게 설정
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A237E), // 파란색
                  padding: EdgeInsets.symmetric(
                      horizontal: 64, vertical: 16), // ← 너비 축소
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: Text(
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

          // 소셜 로그인 아이콘 (Google만 동작)
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
                  tooltip: 'Google로 로그인',
                ),
                const SizedBox(width: 50),
                // Kakao (미구현)
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카카오 로그인은 아직 지원되지 않습니다.')),
                    );
                  },
                  icon: Image.asset('assets/login/kakao.png',
                      width: 36.8, height: 35),
                  tooltip: 'Kakao로 로그인',
                ),
                const SizedBox(width: 50),
                // Naver (미구현)
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('네이버 로그인은 아직 지원되지 않습니다.')),
                    );
                  },
                  icon: Image.asset('assets/login/naver.png',
                      width: 36.8, height: 35),
                  tooltip: 'Naver로 로그인',
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
