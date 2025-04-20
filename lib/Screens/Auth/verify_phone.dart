import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:scalp_pure/Screens/Auth/sign_up.dart';
import 'package:scalp_pure/Screens/Home/home_page.dart';
import 'package:scalp_pure/Widget/AppButtons.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/Widget/AppTextFields.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../components/AppColor.dart';
import '../../components/AppMessage.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final _key = GlobalKey<FormState>();

  TextEditingController pin = TextEditingController();

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: 'Enter pin sent to your phone', fontSize: AppSize.textSize, color: AppColor.darkGray,),
                      SizedBox(height: 20.h,),
                      Pinput(
                        controller: pin,
                        length: 6,
                        validator: (value){
                          if(value!.isEmpty){
                            return AppMessage.mandatoryTx;
                          }
                          return null;
                        },
                        errorTextStyle: TextStyle(
                          color: AppColor.error,
                          fontSize: AppSize.errorSize
                        ),
                        defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.lightGreen),
                              borderRadius: BorderRadius.circular(8),
                            )),
                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AppButtons(
                          height: 45.h,
                          width: double.infinity,
                          backgroundColor: AppColor.lightGreen.withOpacity(.4),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              AppRoutes.pushReplacementTo(
                                  context, const HomePage());
                            }
                          },
                          textStyleColor: AppColor.grayGreen,
                          text: AppMessage.verify),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
