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
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = useTextEditingController();
    final pwdTextController = useTextEditingController();
    final themeMode = ref.watch(themeModeProvider);
    final isLight = themeMode == ThemeMode.light;
    final obscure = useState(true);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: themeMode == ThemeMode.light,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state = value ? ThemeMode.light : ThemeMode.dark;
            },
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
              '선생님의 회원가입을 환영합니다'.text.size(20).make(),
              height30,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력해주세요.';
                        }
                        return null;
                      },
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 입력해 주세요.';
                        }
                        return null;
                      },
                      obscureText: obscure.value,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    height20,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(isLoggedInProvider.notifier).state = true;
                          context.goNamed(AppRouteName.home);
                        }
                      },
                      style: buttonStyle,
                      child: '계정 만들기'.text.make(),
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
