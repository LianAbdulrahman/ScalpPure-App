import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../components/AppColor.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/logo.png',
              color: AppColor.grayGreen,
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 60.h, left: 5.w, right: 5.w),
                    child: AppText(
                      text: 'Make right choices for your hair health!',
                      fontSize: AppSize.titleSize,
                      color: AppColor.darkGray.withOpacity(.8),
                      align: TextAlign.center,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  AppButtons(
                      width: double.infinity,
                      backgroundColor: AppColor.lightGreen.withOpacity(.4),
                      onPressed: () {
                        AppRoutes.pushReplacementTo(context, const HomePage());
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.phone,
                          color: AppColor.grayGreen,
                        ),
                      ),
                      textStyleColor: AppColor.grayGreen,
                      text: 'Sign up with phone'),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppButtons(
                      backgroundColor: AppColor.grayGreen,
                      width: double.infinity,
                      icon: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.mail,
                          color: AppColor.white,
                        ),
                      ),
                      onPressed: () {
                        AppRoutes.pushReplacementTo(context, const HomePage());
                      },
                      textStyleColor: AppColor.white,
                      text: 'Sign up with Google'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
