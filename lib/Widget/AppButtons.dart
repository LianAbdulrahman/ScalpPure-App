import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/AppColor.dart';
import '../components/AppMessage.dart';
import '../components/AppSize.dart';
import '../main.dart';
import 'AppText.dart';

class AppButtons extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textStyleColor;
  final FontWeight? textStyleWeight;
  final TextOverflow? overflow;
  final double? elevation;
  final double? width;
  final double? height;
  final Widget? icon;
  final double? textSize;
  final double? radius;
  final BorderSide? side;
  final Widget? label;
  final AlignmentGeometry? alignment;
  final FontWeight? fontWeight;
  const AppButtons(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.overflow,
      this.textStyleColor,
      this.textStyleWeight,
      this.width,
      this.elevation,
      this.height,
      this.icon,
      this.textSize,
      this.radius,
      this.alignment,
      this.side,
      this.fontWeight,
      this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 50.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((radius ?? 50.r)),
              side: side ?? BorderSide(color: AppColor.green, width: 0.3)),
          backgroundColor: (backgroundColor ?? AppColor.green),
          elevation: elevation ?? 0,
          textStyle: TextStyle(
              fontFamily: GoogleFonts.libreBaskerville().fontFamily,
              color: textStyleColor ?? Colors.black,
              fontSize: AppSize.smallSubText,
              fontStyle: FontStyle.normal,
              fontWeight: fontWeight),
        ),
        onPressed: onPressed,
        icon: icon ?? const SizedBox(),
        label: label ??
            AppText(
              fontSize: textSize ?? AppSize.buttonsFontSize,
              text: text,
              color: textStyleColor ?? Colors.black.withOpacity(0.5),
              fontWeight: fontWeight,
              fontFamily:  GoogleFonts.libreBaskerville().fontFamily,
            ),
      ),
    );
  }
}
