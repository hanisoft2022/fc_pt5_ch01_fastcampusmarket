import 'package:fastcampusmarket/features/auth/data/auth_remote_datasource.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthResult build() {
    // * 초기 상태: 로그인 여부 체크
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthResult(isLogin: true, message: '이미 로그인된 상태입니다.');
    } else {
      return AuthResult(isLogin: false, message: '로그인되지 않은 상태입니다.');
    }
  }

  // * 이메일-비밀번호 로그인
  Future<AuthResult> signInWithEmailAndPassword(email, password) async {
    final AuthResult authResult = await AuthApi.signInWithEmailAndPassword(email, password);
    state = authResult;
    return state;
  }

  // * 구글 로그인
  Future<AuthResult> signInWithGoogle() async {
    final AuthResult authResult = await AuthApi.signInWithGoogle();
    state = authResult;
    return state;
  }

  // * 익명 로그인
  Future<AuthResult> signInAnonymously() async {
    final AuthResult authResult = await AuthApi.signInAnonymously();
    state = authResult;
    return state;
  }

  // * 로그아웃
  Future<void> logout() async {
    await AuthApi.signOut();
    state = AuthResult(isLogin: false, message: '로그아웃 되었습니다.');
  }
}
