import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/features/auth/models/auth_result.dart';
import 'package:fastcampusmarket/features/auth/providers/auth_controller.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/features/auth/views/sign_up_route.dart';
import 'package:fastcampusmarket/features/feed/views/feed_route.dart';
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
    final themeMode = ref.watch(customThemeModeProvider);
    final isLight = themeMode == ThemeMode.light;

    // 텍스트 컨트롤러
    final emailTextController = useTextEditingController();
    final pwdTextController = useTextEditingController();

    // 비밀번호 가리기
    final isObscure = useState(true);

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
      return null;
    }

    // 로그인 버튼 실시간 활성화를 위한 유효 체크 변수
    final isEmailValid = useState(false);
    final isPasswordValid = useState(false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(customThemeModeProvider.notifier).toggleTheme(),
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo/indischool/indischool.png', height: 50),
                height30,
                Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration: InputDecoration(
                        labelText: '이메일',
                        border: OutlineInputBorder(),
                      ),
                      validator: validateEmail,
                      onChanged: (value) {
                        isEmailValid.value = validateEmail(value) == null;
                      },
                      textInputAction: TextInputAction.next, // 다음 필드로 포커스 이동
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    height20,
                    TextFormField(
                      controller: pwdTextController,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(isObscure.value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => isObscure.value = !isObscure.value,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      obscureText: isObscure.value,
                      onChanged: (value) => isPasswordValid.value = validatePassword(value) == null,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    height20,
                    ElevatedButton(
                      onPressed:
                          isEmailValid.value && isPasswordValid.value
                              ? () async {
                                if (formKey.currentState?.validate() == true) {
                                  final authResult = await ref
                                      .watch(authControllerProvider.notifier)
                                      .signInWithEmailAndPassword(
                                        emailTextController.text,
                                        pwdTextController.text,
                                      );
                                  if (authResult.isLogin == true) {
                                    if (context.mounted) {
                                      CustomSnackBar.successSnackBar(context, '로그인에 성공했습니다.');
                                      context.goNamed(FeedRoute.name);
                                    }
                                  } else {
                                    if (context.mounted) {
                                      CustomSnackBar.failureSnackBar(context, authResult.message);
                                    }
                                  }
                                }
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
                      onPressed: () => context.pushNamed(SignUpRoute.name),
                      child: '계정이 없나요? 회원가입'.text.make(),
                    ),
                  ],
                ),
                height15,
                const Divider(),
                height15,
                ClipOval(
                  child: Material(
                    child: Ink.image(
                      height: 100,
                      image: AssetImage(
                        isLight
                            ? 'assets/images/logo/google/light/google_light.png'
                            : 'assets/images/logo/google/dark/google_dark.png',
                      ),
                      child: InkWell(
                        onTap: () async {
                          final AuthResult authResult =
                              await ref.watch(authControllerProvider.notifier).signInWithGoogle();

                          if (authResult.isLogin == true) {
                            if (context.mounted) {
                              CustomSnackBar.successSnackBar(context, 'Google 로그인에 성공했습니다.');

                              context.goNamed(FeedRoute.name);
                            }
                          } else {
                            if (context.mounted) {
                              CustomSnackBar.alertSnackBar(context, 'Google 로그인이 취소되었습니다.');
                            }
                          }
                        },
                        customBorder: const CircleBorder(),
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  label: '바로 로그인'.text.make(),
                  onPressed: () async {
                    final AuthResult authResult =
                        await ref.watch(authControllerProvider.notifier).signInAnonymously();

                    if (authResult.isLogin == true) {
                      if (context.mounted) {
                        context.goNamed(FeedRoute.name);
                        CustomSnackBar.successSnackBar(context, authResult.message);
                      }
                    } else {
                      if (context.mounted) {
                        CustomSnackBar.failureSnackBar(context, '익명 로그인에 실패했습니다.');
                      }
                    }
                  },
                  icon: Icon(Icons.forward),
                ),
              ],
            ).p(20),
          ),
        ),
      ),
    );
  }
}
