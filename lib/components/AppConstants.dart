import 'package:flutter/cupertino.dart';

import 'GeneralWidget.dart';

class AppConstants {
  static BuildContext? context;
  AppConstants();

  //Gemini api key ==================================================================
  static const String geminiApiKey = 'AIzaSyDP1kV23oaKKQCXIrljcf-wP4D8muNPwAc';
  static const String geminiModelVersion = 'gemini-1.5-flash-latest';
  static const String supportEmail = 'fayzeh.i.fazit@gmail.com';
}

class ItemShape {
  double high;
  double width;
  EdgeInsets? margin;
  bool? isHorizontalList = false;
  EdgeInsets? horizontalListMargin;
  double? horizontalListAspectRatio;
  EdgeInsets? horizontalListWidthMargin;
  BorderRadiusGeometry? borderRadius;
  BoxShape? shape;
  ItemShape(
      {required this.high,
      required this.width,
      this.margin,
      this.horizontalListAspectRatio,
      this.horizontalListMargin,
      this.isHorizontalList,
      this.borderRadius,
      this.horizontalListWidthMargin,
      this.shape});
}
