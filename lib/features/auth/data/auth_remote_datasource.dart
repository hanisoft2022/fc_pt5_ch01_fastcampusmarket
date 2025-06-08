import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/common/constants/firestore_collections.dart';
import 'package:fastcampusmarket/features/auth/models/app_user.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  // * 로그인 상태 확인
  static Stream<User?> firebaseAuthState() => FirebaseAuth.instance.authStateChanges();

  // * 이메일-비밀번호 로그인
  static Future<AuthResult> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return const AuthResult(isLogin: true, message: '로그인 성공');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return AuthResult(isLogin: false, message: '회원 정보를 찾을 수 없습니다');
        case 'wrong-password':
          return AuthResult(isLogin: false, message: '비밀번호가 틀렸습니다.');
        case 'invalid-email':
          return AuthResult(isLogin: false, message: '유효하지 않은 이메일 형식입니다.');
        default:
          return AuthResult(isLogin: false, message: '인증 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      return const AuthResult(isLogin: false, message: '알 수 없는 오류가 발생했습니다.');
    }
  }

  // * 구글 로그인
  static Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return const AuthResult(
          isLogin: false,
          message: '사용자가 로그인 창을 닫았습니다.',
          errorCode: 'sign_in_cancelled',
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection(FirestoreCollections.users)
            .withConverter(
              fromFirestore: (snapshot, options) => AppUser.fromJson(snapshot.data()!),
              toFirestore: (value, options) => value.toJson(),
            )
            .doc(user.uid);

        // 읽기
        final docSnapshot = await userDoc.get();

        // 쓰기 (최초 생성 시)
        if (!docSnapshot.exists) {
          await userDoc.set(
            AppUser(
              uid: user.uid,
              email: user.email ?? '',
              displayName: user.displayName,
              photoURL: user.photoURL,
              createdAt: DateTime.now(),
              provider: 'google',
            ),
          );
        }
      }

      return AuthResult(isLogin: true, message: '구글 로그인 성공');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return const AuthResult(
            isLogin: false,
            message: '이미 다른 인증 방식으로 가입된 계정입니다.',
            errorCode: 'account-exists-with-different-credential',
          );
        case 'invalid-credential':
          return const AuthResult(
            isLogin: false,
            message: '인증 정보가 유효하지 않습니다. 다시 시도해주세요.',
            errorCode: 'invalid-credential',
          );
        default:
          return AuthResult(
            isLogin: false,
            message: 'Google 로그인 중 오류가 발생했습니다: ${e.message}',
            errorCode: e.code,
          );
      }
    } catch (e) {
      return const AuthResult(isLogin: false, message: '구글 로그인 중 알 수 없는 오류가 발생했습니다.');
    }
  }

  // * 익명 로그인
  static Future<AuthResult> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return const AuthResult(isLogin: true, message: '익명 로그인 성공');
    } on FirebaseAuthException catch (e) {
      return AuthResult(isLogin: false, message: '익명 로그인 중 오류가 발생했습니다: ${e.message}');
    } catch (e) {
      return const AuthResult(isLogin: false, message: '익명 로그인 중 알 수 없는 오류가 발생했습니다.');
    }
  }

  // * 로그아웃
  static Future<AuthResult> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    return const AuthResult(isLogin: true, message: '로그아웃 성공');
  }
}
