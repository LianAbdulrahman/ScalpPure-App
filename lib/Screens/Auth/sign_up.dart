import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/Screens/Auth/login.dart';
import 'package:scalp_pure/Screens/Auth/signUp_with_email.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppDialog.dart';
import 'package:scalp_pure/Widget/AppSnackBar.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../BackEnd/provider_class.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

BuildContext? con;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 90.h),
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
                  padding: EdgeInsets.only(bottom: 60.h, left: 5.w, right: 5.w),
                  child: AppText(
                    text: AppMessage.mainTitle,
                    fontSize: AppSize.titleSize - 0.5,
                    color: AppColor.darkGray.withOpacity(.8),
                    align: TextAlign.center,
                    overflow: TextOverflow.visible,
                  ),
                ),
                AppButtons(
                    width: double.infinity,
                    backgroundColor: AppColor.lightGreen.withOpacity(.4),
                    onPressed: () {
                      AppRoutes.pushReplacementTo(context, const SignUpPhone());
                    },
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.email,
                        color: AppColor.grayGreen,
                        size: AppSize.appBarIconsSize + 10,
                      ),
                    ),
                    textStyleColor: AppColor.grayGreen,
                    text: AppMessage.signUpEmail),
                SizedBox(
                  height: 10.h,
                ),
                AppButtons(
                    backgroundColor: AppColor.grayGreen,
                    width: double.infinity,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 25.h,
                        width: 25.w,
                        color: AppColor.white,
                      ),
                    ),
                    onPressed: () async {
                      AppDialog.showLoading(context: context);
                      await context
                          .read<ProviderClass>()
                          .signInWithGoogle()
                          .then((credential) {
                        Navigator.pop(con!);
                        credential != null
                            ? {
                                AppRoutes.pushReplacementTo(
                                    context, const HomePage()),
                              }
                            : {
                                AppSnackBar.showInSnackBar(
                                    context: context,
                                    message: AppMessage.somethingWrong,
                                    isSuccessful: false)
                              };
                      });
                    },
                    textStyleColor: AppColor.white,
                    text: AppMessage.signUpGoogle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                    text: AppMessage.youHaveAccount,
                    fontSize: AppSize.smallSubText - 2),
                InkWell(
                    onTap: () {
                      AppRoutes.pushReplacementTo(context, const LogIn());
                    },
                    child: AppText(
                      text: AppMessage.login,
                      fontSize: AppSize.smallSubText - 2,
                      color: AppColor.grayGreen,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
