import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_remote_datasource.dart';
import '../models/auth_result.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<AuthResult> authStateChanges(Ref ref) {
  return AuthApi.firebaseAuthState().asyncMap((user) async {
    return user != null
        ? AuthResult(isLogin: true, message: '로그인됨')
        : AuthResult(isLogin: false, message: '로그아웃됨');
  });
}
