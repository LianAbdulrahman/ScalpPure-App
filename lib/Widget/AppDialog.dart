
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../Screens/Auth/sign_up.dart';
import '../components/AppColor.dart';
import '../components/AppIcons.dart';
import '../components/AppSize.dart';
import 'AppText.dart';

class AppDialog {
  static showLoading({required context}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          con = context;
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            titlePadding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(color: AppColor.white,),
              // child: LottieBuilder.asset(
              //   'assets/lottie/raffle.json',
              //   height: 250.h,
              // ),
            ),
          );
        });
  }

  static infoDialogue(
      {required context, String? message, String? title, String? lottie, Widget? child}) {
    return showDialog(
        barrierDismissible: false,
        barrierColor: AppColor.black.withOpacity(.3),
        context: context,
        builder: (cont) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      children: [
                        Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(cont);
                                    },
                                    icon: Icon(
                                      AppIcons.backArrow,
                                      color: AppColor.white,
                                      size: AppSize.appBarIconsSize - 1,
                                    ),
                                  ),
                                ],
                              ),
                              AppText(
                                  text: title ?? '',
                                  fontSize: AppSize.appBarTextSize ,
                                  color: AppColor.white,
                                  textDecoration: TextDecoration.none),
                              SizedBox(
                                width: 30.w,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15.w,
                            top: 15.h,
                            right: 15.w,
                          ),
                          child: AppText(
                            text: message ?? '',
                            fontSize: AppSize.subTitle,
                            color: AppColor.darkGray,
                            overflow: TextOverflow.visible,
                            align: TextAlign.center,
                            textDecoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Visibility(
                            visible: lottie != null,
                            child: Transform.translate(
                                offset: Offset(0, -25.h),
                                child: LottieBuilder.asset(
                                  lottie ?? '',
                                  height: 200.h,
                                ))),
                        Visibility(
                            visible: child != null,
                            child: child?? const SizedBox())
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
