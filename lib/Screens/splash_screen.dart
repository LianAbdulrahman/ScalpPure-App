import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:scalp_pure/components/AppRoutes.dart';

import 'Auth/sign_up.dart';
import 'Home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((v) {
      context.read<ProviderClass>().checkToken().then((token) {
        token == null
            ? {AppRoutes.pushReplacementTo(context, const SignUp())}
            : {AppRoutes.pushReplacementTo(context, const HomePage())};
      });
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
