import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    try {
      // 1️⃣ 기존 로그인 세션 제거
      await FirebaseAuth.instance.signOut(); // Firebase에서 로그아웃
      await GoogleSignIn().signOut(); // Google 세션 로그아웃

      // 2️⃣ 계정 선택 창 강제 표시
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userCredential.user?.uid ?? '');
      await prefs.setString('token', googleAuth.idToken ?? '');
      await prefs.setBool('onboarded', false);

      return true;
    } catch (e) {
      print("❌ Google 로그인 실패: $e");
      return false;
    }
  }
}
