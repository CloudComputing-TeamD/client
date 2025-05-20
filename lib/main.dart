import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/my_page.dart';
import 'screens/schedule_page.dart';
import 'screens/login_page.dart';
import 'screens/chatbot_page.dart';
import 'screens/routine_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
              settings: settings,
            );
          case '/home':
            return MaterialPageRoute(
              builder: (_) => const HomePage(),
              settings: settings,
            );
          case '/schedule':
            return MaterialPageRoute(
              builder: (_) => const SchedulePage(),
              settings: settings,
            );
          case '/mypage':
            return MaterialPageRoute(
              builder: (_) => const MyPage(),
              settings: settings,
            );
          case '/chatbot':
            return MaterialPageRoute(
              builder: (_) => const ChatbotPage(),
              settings: settings,
            );
          case '/routine':
            final args = settings.arguments;
            if (args is String) {
              return MaterialPageRoute(
                builder: (_) => RoutinePage(routineTitle: args),
                settings: settings,
              );
            } else {
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('잘못된 루틴 접근')),
                ),
              );
            }

          default:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(), // fallback
              settings: const RouteSettings(name: '/login'),
            );
        }
      },
    );
  }
}
