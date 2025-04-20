import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/Widget/AppTextFields.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

class SignUpPhone extends StatefulWidget {
  const SignUpPhone({super.key});

  @override
  State<SignUpPhone> createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final _key = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.r),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
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
                  padding:
                      EdgeInsets.only(right: 12.w, left: 12.w, bottom: 30.h),
                  child: Column(
                    children: [
                      AppTextFields(
                          validator: (phone) {
                            if (phone!.trim().isEmpty) {
                              return AppMessage.mandatoryTx;
                            }
                            if (!phone.startsWith('0')) {
                              return AppMessage.startWith0;
                            }
                            if (phone.length != 10) {
                              return AppMessage.noLessThan10;
                            }
                            return null;
                          },
                          controller: phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintColor: AppColor.lightGrey,
                          hintText: 'phone number'),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFields(
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return AppMessage.mandatoryTx;
                            } else if (pass.length < 8) {
                              return AppMessage.invalidPassword;
                            } else {
                              return null;
                            }
                          },
                          controller: password,
                          obscureText: true,
                          hintColor: AppColor.lightGrey,
                          hintText: 'password'),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFields(
                          validator: (confirmPassword) {
                            if (confirmPassword!.isEmpty) {
                              return AppMessage.mandatoryTx;
                            } else if (confirmPassword.length < 8) {
                              return AppMessage.invalidPassword;
                            } else if (confirmPassword != password.text) {
                              return AppMessage.noMatch;
                            } else {
                              return null;
                            }
                          },
                          controller: confirmPassword,
                          obscureText: true,
                          hintColor: AppColor.lightGrey,
                          hintText: 'confirm password'),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppButtons(
                          height: 45.h,
                          width: double.infinity,
                          backgroundColor: AppColor.lightGreen.withOpacity(.4),
                          onPressed: () {
                            if(_key.currentState!.validate()){
                              AppRoutes.pushReplacementTo(
                                  context, const HomePage());
                            }
                          },
                          textStyleColor: AppColor.grayGreen,
                          text: AppMessage.signUp),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Flexible(
                                child: Divider(
                              color: AppColor.lightGrey.withOpacity(.3),
                            )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              'assets/images/google.png',
                              height: 25.h,
                              width: 25.w,
                            ),
                            AppText(
                                text: '  ${AppMessage.signUpGoogle}  ',
                                color: AppColor.darkGray,
                                fontSize: AppSize.smallSubText - 2),
                            Flexible(
                              child: Divider(
                                color: AppColor.lightGrey.withOpacity(.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
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
                            AppRoutes.pushReplacementTo(
                                context, const SignUp());
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
          ),
        ),
      ),
    );
  }
}
