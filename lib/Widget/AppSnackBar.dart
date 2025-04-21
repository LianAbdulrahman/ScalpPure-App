import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/AppColor.dart';
import '../components/AppIcons.dart';
import '../components/AppSize.dart';
import 'AppText.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static showInSnackBar(
      {required context,
      required String message,
      required bool isSuccessful,
      Duration? duration,
      double? bottomPadding}) {
    var snackBar = SnackBar(
      content: Container(
        padding:
            EdgeInsets.only(top: 15.w, bottom: 15.w, right: 8.w, left: 8.w),
        decoration: BoxDecoration(
            color: isSuccessful
                ? AppColor.green.withOpacity(0.08)
                : AppColor.error,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              width: 1,
              color: isSuccessful ? AppColor.green : AppColor.white,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              //  width: 260.w,
              child: AppText(
                text: message,
                fontSize: AppSize.snackBarTextSize,
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            CircleAvatar(
              backgroundColor: AppColor.white,
              radius: 13.r,
              child: Icon(
                isSuccessful ? AppIcons.success : AppIcons.fail,
                size: AppSize.iconsSize - 2,
                color: isSuccessful ? Colors.green[200] : Colors.red,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: bottomPadding ?? 20.h, right: 20.w, left: 20.w),
      padding: EdgeInsets.zero,
      backgroundColor:
          isSuccessful ? Colors.green[200] : Colors.red.withOpacity(0.7),
      elevation: 20,
      duration: duration ?? const Duration(seconds: 2),
    );
    // Step 3

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
