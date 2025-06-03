import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-url.com'; // 실제 URL로 교체

  static Future<bool> submitUserInfo({
    required String email,
    required String gender,
    required int height,
    required int weight,
    required String birthDate,
    required String goal,
    required List<String> targetParts,
    required int frequency,
    required String workoutLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    final response = await http.post(
      Uri.parse('$baseUrl/users/signup'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "email": email,
        "gender": gender,
        "height": height,
        "weight": weight,
        "birthDate": birthDate,
        "goal": goal,
        "targetParts": targetParts,
        "frequency": frequency,
        "workoutLevel": workoutLevel,
      }),
    );

    return response.statusCode == 200;
  }
}
