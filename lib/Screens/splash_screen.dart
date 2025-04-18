import 'package:flutter/material.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:scalp_pure/components/AppRoutes.dart';

import 'Auth/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((v) {
      AppRoutes.pushReplacementTo(context, const SignUp());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColor.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              color: AppColor.grayGreen,
            )
          ],
        ),
      ),
    );
  }
}
