import 'package:fastcampusmarket/features/auth/data/auth_remote_datasource.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() {
    // * 초기 상태: 로그인 여부 체크
    return FirebaseAuth.instance.currentUser != null;
  }

  // * 이메일-비밀번호 로그인
  Future<AuthResult> signInWithEmailAndPassword(email, password) async {
    final AuthResult authResult = await AuthApi.signInWithEmailAndPassword(email, password);
    if (authResult.isSuccess) {
      state = true;
    }
    return authResult;
  }

  // * 구글 로그인
  Future<AuthResult> signInWithGoogle() async {
    final AuthResult authResult = await AuthApi.signInWithGoogle();
    if (authResult.isSuccess) {
      state = true;
    }
    return authResult;
  }

  // * 로그아웃
  Future<void> logout() async {
    await AuthApi.signOut();
    state = false;
  }
}
