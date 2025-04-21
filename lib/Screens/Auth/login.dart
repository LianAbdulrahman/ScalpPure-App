import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Screens/Auth/verify_phone.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/Widget/AppTextFields.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../Widget/AppDialog.dart';
import '../../Widget/AppSnackBar.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _key = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();

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
                          validator: (phone) {
                            if (phone!.trim().isEmpty) {
                              return AppMessage.mandatoryTx;
                            }
                            if (!phone.startsWith('0')) {
                              return AppMessage.startWith0;
                            }
                            if (phone.length != 9) {
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
                        height: 15.h,
                      ),
                      AppButtons(
                          height: 45.h,
                          width: double.infinity,
                          backgroundColor: AppColor.lightGreen.withOpacity(.4),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '+966 543 646 975',
                                  verificationCompleted: (PhoneAuthCredential
                                      phoneAuthCredential) {},
                                  verificationFailed:
                                      (FirebaseAuthException error) {},
                                  codeSent: (String verificationId,
                                      int? forceResendingToken) {
                                    AppRoutes.pushReplacementTo(
                                        context,
                                        VerifyPhone(
                                          verificationId: verificationId,
                                        ));
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {});
                            }
                          },
                          textStyleColor: AppColor.grayGreen,
                          text: AppMessage.login),
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
                                  text: '  ${AppMessage.logInGoogle}  ',
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
                          text: AppMessage.youDoNotHaveAccount,
                          fontSize: AppSize.smallSubText - 2),
                      InkWell(
                          onTap: () {
                            AppRoutes.pushReplacementTo(
                                context, const SignUp());
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
        ),
      ),
    );
  }
}
