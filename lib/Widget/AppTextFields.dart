import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/AppColor.dart';
import '../components/AppSize.dart';
import '../components/GeneralWidget.dart';
import 'AppText.dart';

class AppTextFields extends StatelessWidget {
  final bool? obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final bool? enable;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final bool? customDesign;
  final Color? fillColor;
  final Color? labelColor;
  final Color? textColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextAlign? textAlignment;
  final Function(String)? onSubmit;
  final String? helperText;
  final TextDirection? textDirection;
  final double? radius;
  final Color? borderColor;
  final Color? focusedColor;
  final Color? hintColor;
  final double? labelSize;
  final double? borderThickness;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final double? hintStyleHeight;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool? readOnly;
  final String? labelText;
  final double? textSize;
  final bool? isFocus;
  const AppTextFields(
      {Key? key,
      required this.validator,
      this.onTap,
      this.inputFormatters,
      this.keyboardType,
      this.hintColor,
      required this.controller,
      required this.hintText,
      this.fontWeight,
      this.obscureText,
      this.minLines,
      this.maxLines,
      this.enable,
      this.customDesign,
      this.fillColor,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.textAlignment,
      this.onSubmit,
      this.helperText,
      this.textDirection,
      this.radius,
      this.borderColor,
      this.labelSize,
      this.focusedColor,
      this.borderThickness,
      this.width,
      this.contentPadding,
      this.hintStyleHeight,
      this.focusNode,
      this.textInputAction,
      this.labelColor,
      this.textColor,
      this.readOnly,
      this.labelText,
      this.onTapOutside,
      this.textSize,
      this.isFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: onTapOutside,
      readOnly: readOnly ?? false,
      enabled: enable ?? true,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: obscureText ?? false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      textAlign: textAlignment ?? TextAlign.start,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      cursorRadius: Radius.circular(20.r),
      cursorColor: AppColor.grayGreen,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit,
      textDirection: textDirection,
      focusNode: focusNode,
      style: AppText.styleText(
        color: textColor ?? AppColor.darkGray,
        fontSize: labelSize ?? AppSize.smallSubText,
      ),
      decoration: InputDecoration(
          helperText: helperText,
          filled: true,
          errorStyle: TextStyle(
              color: AppColor.error,
              fontSize: AppSize.errorSize,
              fontFamily: GoogleFonts.libreBaskerville().fontFamily),
          hintStyle: AppText.styleText(
            color: hintColor ?? AppColor.darkGray,
            fontSize: labelSize ?? AppSize.smallSubText,
          ),
          fillColor: fillColor ?? AppColor.noColor,
          labelStyle: AppText.styleText(
              color: labelColor ?? AppColor.darkGray,
              fontSize: labelSize ?? AppSize.smallSubText),
          border: GeneralWidget.outlineInBorderStyle(
              borderRadius: radius,
              borderColor: borderColor,
              borderThickness: borderThickness ?? 0.7),
          enabledBorder: GeneralWidget.outlineInBorderStyle(
              borderRadius: radius, borderColor: borderColor),
          disabledBorder: GeneralWidget.outlineInBorderStyle(
              borderRadius: radius, borderColor: borderColor),
          focusedBorder: GeneralWidget.outlineInBorderStyle(
              borderColor: borderColor,
              isFocus: isFocus ?? true,
              borderRadius: radius,
              borderThickness: borderThickness ?? 0.7),
          errorBorder: GeneralWidget.outlineInBorderStyle(
              borderRadius: radius,
              borderColor:  AppColor.error,
              borderThickness: 0.7),
          hintText: hintText,
          labelText: labelText,
          contentPadding: contentPadding ??
              EdgeInsets.only(
                  right: AppSize.contentPadding + 4,
                  left: AppSize.contentPadding + 4,
                  bottom: AppSize.contentPadding + 1,
                  top: AppSize.contentPadding + 1),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
    );
  }
}
