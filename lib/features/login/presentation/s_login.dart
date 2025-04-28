import 'package:fastcampusmarket/core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

ButtonStyle get buttonStyle => ButtonStyle(
  minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final pwdTextController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            '인디스쿨'.text.size(40).bold.make(),
            height20,
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: '이메일',
                        border: OutlineInputBorder(),
                      ),
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
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    height20,
                    ElevatedButton(
                      onPressed: () {},
                      style: buttonStyle,
                      child: '로그인'.text.make(),
                    ),
                    height10,
                    TextButton(
                      style: buttonStyle,
                      onPressed: () {},
                      child: '계정이 없나요? 회원가입'.text.make(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).p(20),
      ),
    );
  }
}
