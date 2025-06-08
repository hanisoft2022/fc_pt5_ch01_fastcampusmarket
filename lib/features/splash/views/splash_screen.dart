import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [height20, '현재 화면은 splash screen입니다.'.text.make(), height40],
        ),
      ),
    );
  }
}
