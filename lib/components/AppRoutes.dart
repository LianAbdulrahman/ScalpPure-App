import 'package:flutter/material.dart';

import '../BackEnd/provider_class.dart';
import '../Widget/AppText.dart';

class AppRoutes {
//pushTo========================================================================
  static void pushTo(
    BuildContext context,
    pageName,
  ) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => pageName));
  }

//pushReplacement========================================================================
  static void pushReplacementTo(BuildContext context, pageName) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => pageName));
  }

//push And Remove All Page ========================================================================
  static pushAndRemoveAllPageTo(
    BuildContext context,
    page,
  ) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  //push and refresh ===================================================================================
  static pushThenRefresh(context, pageName, {then}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageName,
        )).then(then);
  }
}
