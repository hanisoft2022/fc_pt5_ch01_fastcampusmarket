import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
abstract class AuthResult with _$AuthResult {
  const AuthResult._();

  const factory AuthResult({required bool? isLogin, required String message, String? errorCode}) =
      _AuthResult;
}
