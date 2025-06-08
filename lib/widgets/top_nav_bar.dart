import 'package:flutter/material.dart';
import '../models/user_data.dart';

class TopNavBar extends StatelessWidget {
  final String assetPrefix;
  final String redirectRoute;
  final UserData? userData;

  const TopNavBar({
    super.key,
    required this.assetPrefix,
    this.redirectRoute = '/home',
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Color(0xFFBFBFC4)),
        ),
      ),
      child: Row(
        children: [
          // 홈 로고
          GestureDetector(
            onTap: () {
              print("홈 로고 클릭됨 - 무조건 HomePage로 이동");

              Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                '/home',
                arguments: userData,
              );
            },
            child: Image.asset('$assetPrefix/logo.png', width: 64, height: 64),
          ),
          const Spacer(),

          // 챗봇
          GestureDetector(
            onTap: () {
              print("Chatbot 버튼 클릭됨");
              final currentRoute = ModalRoute.of(context)?.settings.name;
              if (currentRoute != '/chatbot') {
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                  '/chatbot',
                  arguments: userData,
                );
              }
            },
            child:
                Image.asset('$assetPrefix/chatbot.png', width: 28, height: 28),
          ),

          const SizedBox(width: 10),

          // 스케줄
          GestureDetector(
            onTap: () {
              final currentRoute = ModalRoute.of(context)?.settings.name;
              print("현재 라우트: $currentRoute");
              if (currentRoute != '/schedule') {
                print("➡️ SchedulePage로 이동");
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('/schedule');
              } else {
                print("❌ 이미 SchedulePage이므로 이동하지 않음");
              }
            },
            child:
                Image.asset('$assetPrefix/schedule.png', width: 28, height: 28),
          ),
          const SizedBox(width: 10),

          // 마이페이지
          // 마이페이지
          GestureDetector(
            onTap: () {
              print("MyPage 버튼 클릭됨");
              final currentRoute = ModalRoute.of(context)?.settings.name;
              print(" currentRoute: $currentRoute");

              if (currentRoute == '/schedule') {
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                  '/mypage2',
                  arguments: userData,
                );
              } else if (currentRoute != '/mypage') {
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                  '/mypage',
                  arguments: userData,
                );
              }
            },
            child:
                Image.asset('$assetPrefix/profile.png', width: 28, height: 28),
          ),
        ],
      ),
    );
  }
}
