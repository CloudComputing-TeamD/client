import 'package:flutter/material.dart';
import 'package:frontend/widgets/top_nav_bar.dart';

class MyPage2 extends StatelessWidget {
  const MyPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final level = 2;
    final exp = 340;
    final expToNextLevel = 600;
    final bodyExp = {
      'chest lv1': 80,
      'back lv1': 70,
      'legs lv1': 60,
      'abs lv1': 50,
      'shdlr lv1': 80,
    };

    final characterImage = 'assets/mypage/level2.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),
          const Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: TopNavBar(assetPrefix: 'assets/mypage'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(characterImage, width: 200, height: 200),
                      const SizedBox(height: 16),
                      Text('Lv. $level',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('$exp / $expToNextLevel EXP'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: exp / expToNextLevel,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        color: const Color(0xFF1A237E),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  '부위별 경험치',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard'),
                ),
                const SizedBox(height: 16),
                ...bodyExp.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(entry.key,
                              style: const TextStyle(fontFamily: 'Pretendard')),
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: entry.value / 100,
                            backgroundColor: Colors.grey[300],
                            color: const Color(0xFF1A237E),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${entry.value} EXP'),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
