import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/Screens/Auth/login.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/Widget/AppTextFields.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../BackEnd/provider_class.dart';
import '../../Widget/AppDialog.dart';
import '../../Widget/AppSnackBar.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

class SignUpPhone extends StatefulWidget {
  const SignUpPhone({super.key});

  @override
  State<SignUpPhone> createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool hidePassword = true;
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
                  padding: EdgeInsets.only(
                      top: 30.h, right: 12.w, left: 12.w, bottom: 30.h),
                  child: Column(
                    children: [
                      AppTextFields(
                          validator: (email) {
                            if (email!.trim().isEmpty) {
                              return AppMessage.mandatoryTx;
                            }
                            if (EmailValidator.validate(email.trim()) ==
                                false) {
                              return AppMessage.invalidEmail;
                            }
                            return null;
                          },
                          controller: email,
                          hintColor: AppColor.lightGrey,
                          hintText: 'Email'),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFields(
                          validator: (password) {
                            if (password!.trim().isEmpty) {
                              return AppMessage.mandatoryTx;
                            }
                            if (password.length < 8) {
                              return 'password should be at least 8 characters';
                            }
                            return null;
                          },
                          controller: password,
                          obscureText: hidePassword,
                          hintColor: AppColor.lightGrey,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: hidePassword
                                ? Icon(
                                    AppIcons.hide,
                                    color: AppColor.darkGray,
                                  )
                                : Icon(AppIcons.show, color: AppColor.darkGray),
                          ),
                          hintText: 'Password'),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFields(
                          validator: (confirmPassword) {
                            if (confirmPassword!.trim().isEmpty) {
                              return AppMessage.mandatoryTx;
                            }
                            if (confirmPassword.length < 8) {
                              return 'password should be at least 8 characters';
                            }
                            if (confirmPassword != password.text) {
                              return 'password and confirm password do not match';
                            }
                            return null;
                          },
                          controller: confirmPassword,
                          obscureText: hidePassword,
                          hintColor: AppColor.lightGrey,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: hidePassword
                                ? Icon(
                                    AppIcons.hide,
                                    color: AppColor.darkGray,
                                  )
                                : Icon(AppIcons.show, color: AppColor.darkGray),
                          ),
                          hintText: 'Confirm Password'),
                      SizedBox(
                        height: 15.h,
                      ),
                      AppButtons(
                          height: 45.h,
                          width: double.infinity,
                          backgroundColor: AppColor.lightGreen.withOpacity(.4),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              AppDialog.showLoading(context: context);
                              context
                                  .read<ProviderClass>()
                                  .signUpWithEmail(
                                      email: email.text,
                                      password: password.text)
                                  .then((result) {
                                Navigator.pop(con!);
                                result
                                    ? {
                                        AppRoutes.pushReplacementTo(
                                            context, const HomePage())
                                      }
                                    : {
                                        AppSnackBar.showInSnackBar(
                                            context: context,
                                            message: 'something went wrong',
                                            isSuccessful: false)
                                      };
                              });
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
                            InkWell(
                              onTap: () async {
                                AppDialog.showLoading(context: context);
                                context
                                    .read<ProviderClass>()
                                    .signInWithGoogle()
                                    .then((credential) {
                                  Navigator.pop(con!);
                                  credential != null
                                      ? {
                                          AppRoutes.pushReplacementTo(
                                              context, const HomePage())
                                        }
                                      : {
                                          AppSnackBar.showInSnackBar(
                                              context: context,
                                              message: 'something went wrong',
                                              isSuccessful: false)
                                        };
                                });
                              },
                              child: AppText(
                                  text: '  ${AppMessage.signUpGoogle}  ',
                                  color: AppColor.darkGray,
                                  fontSize: AppSize.smallSubText - 2),
                            ),
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
          ),
        ),
      ),
    );
  }
}
