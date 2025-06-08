import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_data.dart';

class ApiService {
  static const String baseUrl = 'http://172.30.1.58:8080';

  static Future<bool> submitUserInfo(UserData userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token'); // 토큰이 저장되어 있어야 함
      final email = prefs.getString('email'); // email도 필요

      if (token == null || email == null) {
        print('❌ 토큰 또는 이메일 없음');
        return false;
      }

      final url = Uri.parse('$baseUrl/users/signup');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "email": email,
          "gender": userData.gender,
          "height": userData.height,
          "weight": userData.weight,
          "birthDate": userData.birthDate?.toIso8601String().split('T').first,
          "goal": userData.goal,
          "targetParts": userData.targetParts,
          "frequency": userData.frequency,
          "workoutLevel": userData.workoutLevel,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ 유저 정보 전송 성공");
        return true;
      } else {
        print("❌ 실패: ${response.statusCode} ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ 예외 발생: $e");
      return false;
    }
  }
}
