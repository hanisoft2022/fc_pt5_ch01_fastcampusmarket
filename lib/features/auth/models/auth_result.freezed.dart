// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthResult {

 bool? get isLogin; String get message; String? get errorCode;
/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultCopyWith<AuthResult> get copyWith => _$AuthResultCopyWithImpl<AuthResult>(this as AuthResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResult&&(identical(other.isLogin, isLogin) || other.isLogin == isLogin)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode => Object.hash(runtimeType,isLogin,message,errorCode);

@override
String toString() {
  return 'AuthResult(isLogin: $isLogin, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $AuthResultCopyWith<$Res>  {
  factory $AuthResultCopyWith(AuthResult value, $Res Function(AuthResult) _then) = _$AuthResultCopyWithImpl;
@useResult
$Res call({
 bool? isLogin, String message, String? errorCode
});




}
/// @nodoc
class _$AuthResultCopyWithImpl<$Res>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._self, this._then);

  final AuthResult _self;
  final $Res Function(AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLogin = freezed,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
isLogin: freezed == isLogin ? _self.isLogin : isLogin // ignore: cast_nullable_to_non_nullable
as bool?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _AuthResult extends AuthResult {
  const _AuthResult({required this.isLogin, required this.message, this.errorCode}): super._();
  

@override final  bool? isLogin;
@override final  String message;
@override final  String? errorCode;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResultCopyWith<_AuthResult> get copyWith => __$AuthResultCopyWithImpl<_AuthResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResult&&(identical(other.isLogin, isLogin) || other.isLogin == isLogin)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode => Object.hash(runtimeType,isLogin,message,errorCode);

@override
String toString() {
  return 'AuthResult(isLogin: $isLogin, message: $message, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$AuthResultCopyWith<$Res> implements $AuthResultCopyWith<$Res> {
  factory _$AuthResultCopyWith(_AuthResult value, $Res Function(_AuthResult) _then) = __$AuthResultCopyWithImpl;
@override @useResult
$Res call({
 bool? isLogin, String message, String? errorCode
});




}
/// @nodoc
class __$AuthResultCopyWithImpl<$Res>
    implements _$AuthResultCopyWith<$Res> {
  __$AuthResultCopyWithImpl(this._self, this._then);

  final _AuthResult _self;
  final $Res Function(_AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLogin = freezed,Object? message = null,Object? errorCode = freezed,}) {
  return _then(_AuthResult(
isLogin: freezed == isLogin ? _self.isLogin : isLogin // ignore: cast_nullable_to_non_nullable
as bool?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
