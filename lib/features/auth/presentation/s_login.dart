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

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 테마
    final themeMode = ref.watch(themeModeProvider);
    final isLight = themeMode == ThemeMode.light;

    // 텍스트 컨트롤러
    final emailTextController = useTextEditingController();
    final pwdTextController = useTextEditingController();

    // 비밀번호 가리기
    final obscure = useState(true);

    // 에러 메시지
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);

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
      return null;
    }

    void handleEmailChange(String value) => emailError.value = validateEmail(value);
    void handlePasswordChange(String value) => passwordError.value = validatePassword(value);

    final isAllValid =
        emailError.value == null && passwordError.value == null && emailTextController.text.isNotEmpty && pwdTextController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(themeModeProvider.notifier).state = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo/indischool/indischool.png', height: 50),
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
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(obscure.value ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          obscure.value = !obscure.value;
                        },
                      ),
                      errorText: passwordError.value,
                    ),
                    onChanged: handlePasswordChange,
                    obscureText: obscure.value,
                    keyboardType: TextInputType.visiblePassword,
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
                    child: '로그인'.text.make(),
                  ),
                ],
              ),
              height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () => context.pushNamed(AppRouteName.signUp),
                    child: '계정이 없나요? 회원가입'.text.make(),
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
