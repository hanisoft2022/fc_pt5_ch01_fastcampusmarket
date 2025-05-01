import 'package:fastcampusmarket/core/common/common.dart';
import 'package:fastcampusmarket/core/router/app_router.dart';
import 'package:fastcampusmarket/core/router/auth_provider.dart';
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
    final obscurePwd = useState(true);
    final obscurePwdConfirm = useState(true);

    // 에러 메시지
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final confirmPasswordError = useState<String?>(null);

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
    String? validateConfirmPassword(String? value, String original) {
      if (value == null || value.isEmpty) return '재확인 비밀번호를 입력해주세요.';
      if (value != original) return '비밀번호가 일치하지 않습니다.';
      return null;
    }

    // 실시간 검증 핸들러
    void handleEmailChange(String value) => emailError.value = validateEmail(value);
    void handlePasswordChange(String value) => passwordError.value = validatePassword(value);
    void handleConfirmPasswordChange(String value) => confirmPasswordError.value = validateConfirmPassword(value, pwdTextController.text);

    final isAllValid =
        emailError.value == null &&
        passwordError.value == null &&
        confirmPasswordError.value == null &&
        emailTextController.text.isNotEmpty &&
        pwdTextController.text.isNotEmpty &&
        confirmPwdTextController.text.isNotEmpty;

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
              Column(
                children: [
                  TextFormField(
                    controller: emailTextController,
                    decoration: InputDecoration(labelText: '이메일', border: OutlineInputBorder(), errorText: emailError.value),
                    onChanged: handleEmailChange,
                  ),
                  height20,
                  TextFormField(
                    controller: pwdTextController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscurePwd.value,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePwd.value ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => obscurePwd.value = !obscurePwd.value,
                      ),
                      errorText: passwordError.value,
                      helperText: '대문자, 숫자, 특수문자 1개 이상',
                    ),
                    onChanged: (value) {
                      handlePasswordChange(value);
                      handleConfirmPasswordChange(confirmPwdTextController.text);
                    },
                  ),
                  height20,
                  TextFormField(
                    controller: confirmPwdTextController,
                    decoration: InputDecoration(
                      labelText: '비밀번호 재확인',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePwdConfirm.value ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => obscurePwdConfirm.value = !obscurePwdConfirm.value,
                      ),
                      errorText: confirmPasswordError.value,
                    ),
                    obscureText: obscurePwdConfirm.value,
                    onChanged: handleConfirmPasswordChange,
                  ),
                  height20,
                  ElevatedButton(
                    onPressed:
                        isAllValid
                            ? () {
                              ref.read(isLoggedInProvider.notifier).state = true;
                              context.goNamed(AppRouteName.home);
                            }
                            : null,
                    style: buttonStyle,
                    child: '회원가입'.text.make(),
                  ),
                ],
              ),
              height15,
              const Divider(),
              height15,
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  isLight ? 'assets/images/logo/google/light/google_light.png' : 'assets/images/logo/google/dark/google_dark.png',
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
