import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'package:frontend/services/api_service.dart';
import 'home_page.dart';

class UserInfoInputPage5 extends StatefulWidget {
  final UserData userData;

  const UserInfoInputPage5({super.key, required this.userData});

  @override
  State<UserInfoInputPage5> createState() => _UserInfoInputPage5State();
}

class _UserInfoInputPage5State extends State<UserInfoInputPage5> {
  String _selected = '';

  final Map<String, int> _frequencyMap = {
    '1회': 1,
    '2~3회': 3,
    '4~5회': 5,
    '매일': 7,
  };

  void _onSelect(String label) {
    setState(() {
      _selected = label;
      widget.userData.frequency = _frequencyMap[label];
    });
  }

  void _onNext() async {
    if (_selected.isNotEmpty) {
      // ✅ 2초간 로딩 다이얼로그 보여주기
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(color: Color(0xFF1A237E)),
              SizedBox(width: 20),
              Text("맞춤형 루틴 생성중입니다."),
            ],
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return; // context 유효성 검사

      Navigator.pop(context); // 다이얼로그 닫기

      // ✅ 홈으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(userData: widget.userData),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("운동 빈도를 선택해주세요")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double top = 270;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
              left: 40, top: 20, child: SizedBox(width: 60, height: 24)),

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
                    bottom: BorderSide(width: 0.5, color: Color(0xFFBFBFC4))),
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
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Container(
                    width: 360,
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
              'Q. 일주일에 몇 번 운동하시나요?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 선택지 항목들
          ..._buildOption(top, '1회', '가볍게 시작해보고 싶어요.'),
          ..._buildOption(top += 91, '2~3회', '적당히 꾸준하게 운동하고 싶어요.'),
          ..._buildOption(top += 91, '4~5회', '체계적인 루틴을 실천하고 있어요.'),
          ..._buildOption(top += 91, '매일', '운동은 일상입니다.'),

          // 다음 버튼
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _onNext,
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
    final isSelected = _selected == title;

    return [
      Positioned(
        left: 11,
        top: top,
        child: GestureDetector(
          onTap: () => _onSelect(title),
          child: Container(
            width: 369,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF1A237E)
                  : const Color(0x191A237E),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ),
      Positioned(
        left: 39,
        top: top + 17,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Positioned(
        left: 41,
        top: top + 44,
        child: Text(
          desc,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ];
  }
}
