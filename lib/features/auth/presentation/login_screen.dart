import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/router/auth_provider.dart';
import 'package:fastcampusmarket/core/router/router.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    // 로그인
    Future<void> signIn(String email, String password) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        ref.read(isLoggedInProvider.notifier).state = true;
        if (context.mounted) {
          context.goNamed(FeedRoute.name);
          CustomSnackBar.successSnackBar(context, '로그인에 성공했습니다.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          if (context.mounted) {
            CustomSnackBar.alertSnackBar(context, '회원 정보를 찾을 수 없습니다.');
          }
        }
        if (e.code == 'wrong-password') {
          if (context.mounted) {
            CustomSnackBar.alertSnackBar(context, '비밀번호가 틀렸습니다.');
          }
        }
      } catch (e) {
        if (context.mounted) {
          CustomSnackBar.failureSnackBar(context, '로그인에 실패했습니다.');
        }
      }
    }

    Future<void> signInWithGoogle(BuildContext context) async {
      try {
        // Google 로그인 플로우 시작
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          // 사용자가 로그인 창을 닫은 경우
          if (context.mounted) {
            CustomSnackBar.alertSnackBar(context, 'Google 로그인이 취소되었습니다.');
          }
          return;
        }

        // 인증 정보 가져오기
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Firebase credential 생성
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Firebase에 credential로 로그인 시도
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        final user = userCredential.user;

        // Firestore에 사용자 정보 저장 (최초 로그인 시에만)
        if (user != null) {
          final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

          final docSnapshot = await userDoc.get();
          if (!docSnapshot.exists) {
            await userDoc.set({
              'email': user.email,
              'displayName': user.displayName,
              'photoURL': user.photoURL,
              'createdAt': Timestamp.now(),
              'provider': 'google',
            });
          }
        }

        // 성공 메시지 스낵바
        if (context.mounted) {
          CustomSnackBar.successSnackBar(context, 'Google 로그인에 성공했습니다.');
          ref.read(isLoggedInProvider.notifier).state = true;
          context.goNamed(FeedRoute.name);
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'account-exists-with-different-credential') {
          message = '이미 다른 인증 방식으로 가입된 계정입니다.';
        } else if (e.code == 'invalid-credential') {
          message = '인증 정보가 유효하지 않습니다. 다시 시도해주세요.';
        } else {
          message = 'Google 로그인 중 오류가 발생했습니다: ${e.message}';
        }
        if (context.mounted) {
          CustomSnackBar.failureSnackBar(context, message);
        }
      } catch (e) {
        // 기타 예외 처리
        if (context.mounted) {
          CustomSnackBar.failureSnackBar(context, '알 수 없는 오류가 발생했습니다: $e');
        }
      }
    }

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
                TextButton.icon(
                  label: '성공 스낵바 띄우기'.text.make(),
                  onPressed: () => CustomSnackBar.successSnackBar(context, '실험용 스낵바 띄우기'),
                  icon: Icon(Icons.check_circle),
                ),
                TextButton.icon(
                  label: '실패 스낵바 띄우기'.text.make(),
                  onPressed: () => CustomSnackBar.failureSnackBar(context, '실험용 스낵바 띄우기'),
                  icon: Icon(Icons.cancel),
                ),
                TextButton.icon(
                  label: '경고 스낵바 띄우기'.text.make(),
                  onPressed: () => CustomSnackBar.alertSnackBar(context, '경고 스낵바 띄우기'),
                  icon: Icon(Icons.warning),
                ),
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
                                  await signIn(emailTextController.text, pwdTextController.text);
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
                        onTap: () async => await signInWithGoogle(context),
                        customBorder: const CircleBorder(),
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  label: '바로 로그인'.text.make(),
                  onPressed: () {
                    ref.read(isLoggedInProvider.notifier).state = true;
                    context.goNamed(FeedRoute.name);
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
