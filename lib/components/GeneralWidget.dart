import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppColor.dart';

class GeneralWidget {
  //borderStyle===============================================================================================
  static outlineInBorderStyle(
      {bool? isFocus,
      Color? borderColor,
      double? borderThickness,
      double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
      borderSide: BorderSide(
        color: isFocus == true
            ? AppColor.green
            : (borderColor ?? AppColor.lightGrey),
        width: borderThickness ?? 0.3,
      ),
    );
  }

  static BoxDecoration decoration(
      {bool? shadow,
      bool? radiusOnlyTop,
      bool? radiusOnlyBottom,
      bool? radiusOnlyTopLeftBottomLeft,
      bool? radiusOnlyTopRightBottomRight,
      bool? radiusOnlyTopLeft,
      bool? radiusOnlyTopRight,
      bool? radiusOnlyBottomLeft,
      bool? radiusOnlyBottomRight,
      Color? color,
      Color? shadowColor,
      double radius = 10,
      bool showBorder = false,
      Color? borderColor,
      double borderWidth = 0.5,
      ImageProvider<Object>? image,
      bool cover = false,
      double? blurRadius,
      ColorFilter? colorFilter,
      bool? isCircle,
      BorderRadiusGeometry? borderRadius,
      bool isGradient = false}) {
    return BoxDecoration(
        shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
        border: showBorder == true
            ? Border.all(
                color: borderColor ?? AppColor.lightGrey, width: borderWidth)
            : null,
        color: isGradient == true ? null : (color ?? AppColor.white),
        borderRadius: isCircle == true
            ? null
            : (borderRadius ??
                (radiusOnlyTop == true
                    ? BorderRadius.only(
                        topRight: Radius.circular(radius.r),
                        topLeft: Radius.circular(radius.r),
                      )
                    : radiusOnlyBottom == true
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(radius.r),
                            bottomRight: Radius.circular(radius.r))
                        : radiusOnlyTopLeftBottomLeft == true
                            ? BorderRadius.only(
                                topLeft: Radius.circular(radius.r),
                                bottomLeft: Radius.circular(radius.r),
                              )
                            : radiusOnlyTopRightBottomRight == true
                                ? BorderRadius.only(
                                    topRight: Radius.circular(radius.r),
                                    bottomRight: Radius.circular(radius.r))
                                : radiusOnlyTopRight == true
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(radius.r),
                                      )
                                    : radiusOnlyTopLeft == true
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(radius.r),
                                          )
                                        : radiusOnlyBottomLeft == true
                                            ? BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(radius.r),
                                              )
                                            : radiusOnlyBottomRight == true
                                                ? BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                            radius.r),
                                                  )
                                                : BorderRadius.all(
                                                    Radius.circular(
                                                        radius.r)))),
        boxShadow: shadow == null
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.grey.withOpacity(0.5),
                  offset: const Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ]
            : null);
  }
}
