import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Image.asset(
                'assets/images/logo.png',
                color: AppColor.grayGreen,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 30.h),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 60.h, left: 5.w, right: 5.w),
                    child: AppText(
                      text: AppMessage.mainTitle,
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
                      text: AppMessage.logInPhone),
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
                      text: AppMessage.logInGoogle),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                      text: AppMessage.youDoNotHaveAccount,
                      fontSize: AppSize.smallSubText - 2),
                  InkWell(
                      onTap: () {
                        AppRoutes.pushReplacementTo(context, const SignUp());
                      },
                      child: AppText(
                        text: AppMessage.signUp,
                        fontSize: AppSize.smallSubText - 2,
                        color: AppColor.grayGreen,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
