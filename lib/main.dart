import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'screens/home_page.dart';
import 'screens/my_page.dart';
import 'screens/my_page2.dart';
import 'screens/schedule_page.dart';
import 'screens/login_page.dart';
import 'screens/chatbot_page.dart';
import 'screens/routine_page.dart';
import 'screens/user_info_input_page1_5.dart';
import 'screens/user_info_input_page2.dart';
import 'screens/user_info_input_page3.dart';
import 'screens/user_info_input_page4.dart';
import 'models/user_data.dart';
import 'screens/user_info_input_page1.dart';
import 'screens/user_info_input_page5.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

void handleLoginSuccess(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final isOnboarded = prefs.getBool('onboarded') ?? false;

  if (isOnboarded) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    Navigator.pushReplacementNamed(context, '/user_info_input_page1');
  }
}

Future<http.Response> authorizedGet(String url) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 401) {
    prefs.clear(); // 토큰 제거
    navigatorKey.currentState?.pushReplacementNamed('/login');
  }

  return response;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<Uri>? _linkSub;

  @override
  void initState() {
    super.initState();
    _initAppLinks();
  }

  void _initAppLinks() async {
    final appLinks = AppLinks();
    _linkSub = appLinks.uriLinkStream.listen((Uri? uri) async {
      debugPrint('🔗 딥링크 수신됨: $uri');

      if (uri != null) {
        final prefs = await SharedPreferences.getInstance();

        final userId = uri.queryParameters['user_id'];
        final token = uri.queryParameters['token'];

        debugPrint('🧩 추출된 user_id: $userId');
        debugPrint('🧩 추출된 token: $token');

        if (userId != null) {
          await prefs.setString('user_id', userId);
          debugPrint('Saved userid: $userId');
        }

        if (token != null) {
          await prefs.setString('token', token);
          debugPrint('Saved token: $token');
        }

        final userData = UserData(
          id: userId ?? '',
          token: token ?? '',
          email: '', // 기본값, 이후 필요시 서버에서 조회 가능
          name: '',
        );

        debugPrint(
            '📦 생성된 UserData: id=${userData.id}, token=${userData.token}');

        if (uri.path == '/home') {
          debugPrint('➡️ 라우팅: /home');
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            '/home',
            (_) => false,
            arguments: userData,
          );
        } else if (uri.path == '/users/signup') {
          debugPrint('➡️ 라우팅: /user_info_input_page1');
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            '/user_info_input_page1',
            (_) => false,
            arguments: userData,
          );
        } else {
          debugPrint('⚠️ 알 수 없는 URI 경로: ${uri.path}');
        }
      } else {
        debugPrint('⚠️ 수신된 URI가 null입니다.');
      }
    });
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    _clearUserIdOnExit();
    super.dispose();
  }

  void _clearUserIdOnExit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }

        return MaterialApp(
          navigatorKey: navigatorKey,
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: snapshot.data,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                  settings: settings,
                );
              case '/home':
                final args = settings.arguments;
                print("🧩 Received args: ${args.runtimeType}");
                print("🧩 args: $args");
                if (args is UserData) {
                  return MaterialPageRoute(
                    builder: (_) => HomePage(userData: args),
                    settings: settings,
                  );
                } else {
                  print("❌ UserData 타입 아님. /login으로 fallback");
                  return MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                    settings: const RouteSettings(name: '/login'),
                  );
                }

              case '/schedule':
                return MaterialPageRoute(
                  builder: (_) => const SchedulePage(),
                  settings: settings,
                );
              case '/mypage':
                final args = settings.arguments;
                if (args is UserData) {
                  return MaterialPageRoute(
                    builder: (_) => MyPage(userData: args),
                    settings: settings,
                  );
                } else {
                  return MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  );
                }

              case '/chatbot':
                final args = settings.arguments;
                if (args is UserData) {
                  return MaterialPageRoute(
                    builder: (_) => ChatbotPage(userData: args),
                    settings: settings,
                  );
                } else {
                  return MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  );
                }

              case '/user_info_input_page1':
                final args = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage(userData: args),
                  settings: settings,
                );
              case '/user_info_input_page1_5':
                final args = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage1_5(userData: args),
                  settings: settings,
                );
              case '/user_info_input_page2':
                final args = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage2(userData: args),
                  settings: settings,
                );
              case '/user_info_input_page3':
                final args = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage3(userData: args),
                  settings: settings,
                );
              case '/user_info_input_page4':
                final args = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage4(userData: args),
                  settings: settings,
                );
              case '/user_info_input_page5':
                final userData = settings.arguments as UserData;
                return MaterialPageRoute(
                  builder: (_) => UserInfoInputPage5(userData: userData),
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
              case '/mypage2':
                return MaterialPageRoute(
                  builder: (_) => const MyPage2(),
                  settings: settings,
                );

              default:
                return MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                  settings: const RouteSettings(name: '/login'),
                );
            }
          },
        );
      },
    );
  }

  Future<String?> _getInitialRoute() async {
    return '/login';
  }
}
