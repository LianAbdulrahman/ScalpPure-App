import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final Color? color;
  final TextOverflow? overflow;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final List<Shadow>? shadow;
  final TextDirection? textDirection;
  final bool? softWrap;
  final int? maxLine;
  const AppText(
      {Key? key,
      required this.text,
      this.align,
      this.color,
      this.overflow,
      this.fontFamily,
      required this.fontSize,
      this.fontWeight,
      this.textDecoration,
      this.textHeight,
      this.shadow,
      this.textDirection,
      this.softWrap,
      this.maxLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      textDirection: textDirection,
      softWrap: softWrap,
      maxLines: maxLine,
      style: TextStyle(
          color: color,
          overflow: overflow ?? TextOverflow.ellipsis,
          fontFamily: fontFamily ??
               GoogleFonts.libreBaskerville().fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
          decorationColor: color,
          height: textHeight,
          shadows: shadow),
    );
  }

  static styleText({
    Color? color,
    TextOverflow? overflow,
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
    List<Shadow>? shadow,
  }) {
    return TextStyle(
        color: color,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontFamily: fontFamily ??
            GoogleFonts.libreBaskerville().fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: color,
        height: textHeight,
        shadows: shadow);
  }
}
