// lib/services/auth_service.dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<String?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;
      return auth?.idToken;
    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> authenticateWithServer(String idToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://your-api-domain.com/oauth2/authorization/google'),
        headers: {'Authorization': 'Bearer $idToken'},
      );

      if (response.statusCode == 302) {
        return {
          'location': response.headers['location'],
          'user_id': response.headers['user_id'], // 서버가 user_id 헤더로 보내는 경우
        };
      }
    } catch (e) {
      print('Server error: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> loginWithEmail(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api-domain.com/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(
            response.body); // { "user_id": "...", "redirect": "/home" }
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }
}
