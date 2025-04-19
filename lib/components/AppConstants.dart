import 'package:flutter/cupertino.dart';

import 'GeneralWidget.dart';

class AppConstants {
  static BuildContext? context;
  AppConstants();
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
