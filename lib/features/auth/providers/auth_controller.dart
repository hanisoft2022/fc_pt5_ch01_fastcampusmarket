import 'package:fastcampusmarket/features/auth/data/auth_remote_datasource.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:fastcampusmarket/features/auth/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  @override
  AuthResult build() {
    return ref
        .watch(authStateChangesProvider)
        .when(
          data: (result) {
            return result;
          },
          error: (_, __) {
            return AuthResult(isLogin: false, message: '오류 발생');
          },
          loading: () {
            return AuthResult(isLogin: null, message: '로딩 중');
          },
        );
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
