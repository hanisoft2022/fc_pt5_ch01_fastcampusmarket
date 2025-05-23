import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/core/common/common.dart';
import 'package:fastcampusmarket/core/router/router.dart';
import 'package:fastcampusmarket/shared/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/theme/theme_mode_provider.dart';

ButtonStyle get buttonStyle => ButtonStyle(
  minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
);

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 테마
    final themeMode = ref.watch(themeModeProvider);
    final isLight = themeMode == ThemeMode.light;

    // 텍스트 컨트롤러
    final emailTextController = useTextEditingController();
    final pwdTextController = useTextEditingController();
    final confirmPwdTextController = useTextEditingController();

    // 비밀번호 가리기
    final isPwdObscure = useState(true);
    final isPwdConfirmObscure = useState(true);

    // Form 상태를 위한 key
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // 이메일 검증
    String? validateEmail(String? value) {
      value = value?.trim();
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (value == null || value.isEmpty) return '이메일을 입력해주세요.';
      if (!emailRegex.hasMatch(value)) return '유효하지 않은 이메일 형식입니다.';
      return null;
    }

    // 비밀번호 검증
    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) return '비밀번호를 입력해주세요.';
      if (value.length < 8) return '8자 이상 입력해주세요.';
      if (!RegExp(r'[A-Z]').hasMatch(value)) return '대문자를 1개 이상 포함하세요.';
      if (!RegExp(r'[a-z]').hasMatch(value)) return '소문자를 1개 이상 포함하세요.';
      if (!RegExp(r'[0-9]').hasMatch(value)) return '숫자를 1개 이상 포함하세요.';
      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) return '특수문자를 1개 이상 포함하세요.';
      // 너무 쉬운 패턴 거부
      final easyList = ['12345678', '12341234', 'password', 'qwerty1234'];
      if (easyList.contains(value.toLowerCase())) return '너무 쉬운 비밀번호는 사용할 수 없습니다.';
      return null;
    }

    // 비밀번호 재확인 검증
    String? validateConfirmPassword(String original, String? value) {
      if (value == null || value.isEmpty) return '재확인 비밀번호를 입력해주세요.';
      if (value != original) return '비밀번호가 일치하지 않습니다.';
      return null;
    }

    // 회원가입 버튼 실시간 활성화를 위한 유효 체크 변수
    final isEmailValid = useState(false);
    final isPasswordValid = useState(false);
    final isPasswordConfirmValid = useState(false);
    // final isAllValid = useMemoized(
    //   () => isEmailValid.value && isPasswordValid.value && isPasswordConfirmValid.value,
    // );

    // 회원가입
    Future<void> signUp(String email, String password) async {
      try {
        // Firebase Authentication 유저 생성
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user;

        // Firebase Firestore에 사용자 정보 삽입
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': email,
            'createdAt': Timestamp.now(),
          });
        }

        // 성공 스낵바
        if (context.mounted) {
          CustomSnackBar.successSnackBar(context, '회원가입을 축하드립니다!\n로그인을 해주세요.');
          context.goNamed(LoginRoute.name);
        }
      } on FirebaseAuthException catch (e) {
        String message = '알 수 없는 오류가 발생했습니다.';
        if (e.code == 'weak-password') {
          message = '비밀번호가 쉬운 약합니다.';
        } else if (e.code == 'email-already-in-use') {
          message = '이미 사용중인 이메일입니다.';
        }
        // 경고 스낵바
        if (context.mounted) CustomSnackBar.alertSnackBar(context, message);
      } catch (e) {
        if (context.mounted) CustomSnackBar.failureSnackBar(context, '회원가입에 실패했습니다.\n다시 시도해보세요.');
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo/indischool/indischool.png', height: 50),
              height30,
              '선생님의 회원가입을 환영합니다'.text.size(20).make(),
              height30,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                        labelText: '이메일',
                        border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: validateEmail,
                      onChanged: (value) => isEmailValid.value = validateEmail(value) == null,
                    ),
                    height20,
                    TextFormField(
                      controller: pwdTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isPwdObscure.value,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(isPwdObscure.value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => isPwdObscure.value = !isPwdObscure.value,
                        ),
                        helperText: '대문자, 숫자, 특수문자 1개 이상',
                      ),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: validatePassword,
                      onChanged: (value) => isPasswordValid.value = validatePassword(value) == null,
                    ),
                    height20,
                    TextFormField(
                      controller: confirmPwdTextController,
                      decoration: InputDecoration(
                        labelText: '비밀번호 재확인',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPwdConfirmObscure.value ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () => isPwdConfirmObscure.value = !isPwdConfirmObscure.value,
                        ),
                      ),
                      obscureText: isPwdConfirmObscure.value,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) => validateConfirmPassword(pwdTextController.text, value),
                      onChanged:
                          (value) =>
                              isPasswordConfirmValid.value =
                                  validateConfirmPassword(value, pwdTextController.text) == null,
                    ),
                    height20,
                    ElevatedButton(
                      onPressed:
                          isEmailValid.value &&
                                  isPasswordValid.value &&
                                  isPasswordConfirmValid.value
                              ? () async {
                                if (formKey.currentState?.validate() == true) {
                                  await signUp(emailTextController.text, pwdTextController.text);
                                }
                              }
                              : null,
                      style: buttonStyle,
                      child: '회원가입'.text.make(),
                    ),
                  ],
                ),
              ),
              height15,
              const Divider(),
              height15,
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  isLight
                      ? 'assets/images/logo/google/light/google_light.png'
                      : 'assets/images/logo/google/dark/google_dark.png',
                  width: 100,
                ),
              ),
            ],
          ).p(20),
        ),
      ),
    );
  }
}
