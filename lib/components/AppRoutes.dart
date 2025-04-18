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
  static pushAndRemoveAllPageTo(BuildContext context, page,
      {bool? noAnimation, required bool removeProviderData}) {
    // if (removeProviderData == true) {
    //   ProviderScope.containerOf(context).invalidate(storyProvider);
    //   ProviderScope.containerOf(context).invalidate(noteProvider);
    //   ProviderScope.containerOf(context).invalidate(commentsProvider);
    //   ProviderScope.containerOf(context).invalidate(followingProvider);
    //   ProviderScope.containerOf(context).invalidate(intProfileProvider);
    //   ProviderScope.containerOf(context).invalidate(userProfileDataProvider);
    //   ProviderScope.containerOf(context).invalidate(messageProvider);
    //   ProviderScope.containerOf(context).invalidate(ordersProvider);
    //   ProviderScope.containerOf(context).invalidate(liveProvider);
    //   ProviderScope.containerOf(context).read(authProvider).emptyProviderData();
    //   color_print('delete');
    // }
    noAnimation != null && noAnimation
        ? Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => page), (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
                // transitionDuration: const Duration(seconds: 1),
                // reverseTransitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) => page,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  var curve = Curves.linear;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
            (route) => false);
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
