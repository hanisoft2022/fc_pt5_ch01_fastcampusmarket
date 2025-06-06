import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  // * 이메일-비밀번호 로그인
  static Future<AuthResult> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return const AuthResult(isSuccess: true, message: '로그인 성공');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return AuthResult(isSuccess: false, message: '회원 정보를 찾을 수 없습니다');
        case 'wrong-password':
          return AuthResult(isSuccess: false, message: '비밀번호가 틀렸습니다.');
        case 'invalid-email':
          return AuthResult(isSuccess: false, message: '유효하지 않은 이메일 형식입니다.');
        default:
          return AuthResult(isSuccess: false, message: '인증 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      return const AuthResult(isSuccess: false, message: '알 수 없는 오류가 발생했습니다.');
    }
  }

  // * 구글 로그인
  static Future<(String, bool)> signInWithGoogle() async {
    try {
      // Google 로그인 플로우 시작
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // 사용자가 로그인 창을 닫은 경우

        return ('사용자가 창 그냥 닫음', false);
      }

      // 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Firebase credential 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase에 credential로 로그인 시도
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      // Firestore에 사용자 정보 저장 (최초 로그인 시에만)
      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'createdAt': Timestamp.now(),
            'provider': 'google',
          });
        }
      }

      return ('로그인 성공', true);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'account-exists-with-different-credential') {
        message = '이미 다른 인증 방식으로 가입된 계정입니다.';
        return (message, false);
      } else if (e.code == 'invalid-credential') {
        message = '인증 정보가 유효하지 않습니다. 다시 시도해주세요.';
        return (message, false);
      } else {
        message = 'Google 로그인 중 오류가 발생했습니다: ${e.message}';
        return (message, false);
      }
    } catch (e) {
      // 기타 예외 처리
      return ('로그인 중 오류가 발생했습니다', false);
    }
  }

  // * 로그아웃
  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
