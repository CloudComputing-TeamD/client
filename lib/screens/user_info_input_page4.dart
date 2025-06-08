import 'package:flutter/material.dart';
import '../models/user_data.dart';

class UserInfoInputPage4 extends StatefulWidget {
  final UserData userData;

  const UserInfoInputPage4({super.key, required this.userData});

  @override
  State<UserInfoInputPage4> createState() => _UserInfoInputPage4State();
}

class _UserInfoInputPage4State extends State<UserInfoInputPage4> {
  final Map<String, List<String>> _options = {
    '상체 (가슴, 등, 어깨 등)': ['상체', '가슴', '등', '어깨'],
    '하체 (허벅지, 엉덩이, 종아리 등)': ['하체', '허벅지', '엉덩이', '종아리'],
    '복부 (복근, 코어 등)': ['복부', '복근', '코어'],
    '전신': ['전신'],
    '유산소 위주': ['유산소'],
  };

  final Set<String> _selectedKeys = {};

  void _toggleSelection(String key) {
    setState(() {
      if (_selectedKeys.contains(key)) {
        _selectedKeys.remove(key);
      } else {
        _selectedKeys.add(key);
      }
    });
  }

  void _onNext() {
    widget.userData.targetParts =
        _selectedKeys.expand((key) => _options[key]!).toSet().toList(); // 중복 제거
    Navigator.pushNamed(
      context,
      '/user_info_input_page5',
      arguments: widget.userData,
    );
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
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Container(
                    width: 300,
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
          ..._options.entries.expand((entry) {
            final key = entry.key;
            final isSelected = _selectedKeys.contains(key);
            final List<Widget> block = [
              Positioned(
                left: 11,
                top: top,
                child: GestureDetector(
                  onTap: () => _toggleSelection(key),
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
                  key.split(' (')[0],
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
                  entry.key.contains('(')
                      ? entry.key.split('(')[1].replaceAll(')', '') +
                          ' 부위를 강화하고 싶어요.'
                      : '',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ];
            top += 91;
            return block;
          }).toList(),
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
}
