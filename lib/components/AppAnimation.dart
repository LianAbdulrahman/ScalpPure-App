import 'package:flutter/material.dart';

class AppAnimatedSwitcher extends StatelessWidget {
  final Widget child; // العنصر الذي تريد تغليفه بالانتقالات
  final Duration duration; // مدة الأنيميشن
  final bool useFade; // استخدام انتقال التلاشي
  final bool useScale; // استخدام انتقال التكبير
  final bool useRotation; // استخدام انتقال الدوران
  final bool useSlide; // استخدام انتقال الانزلاق
  final Axis slideAxis; // محور الانزلاق (أفقي أو عمودي)

  const AppAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.useFade = true,
    this.useScale = false,
    this.useRotation = false,
    this.useSlide = false,
    this.slideAxis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        // البدء بالعنصر الأصلي
        Widget currentChild = child;

        // إضافة تأثير التلاشي إذا كان مفعلاً
        if (useFade) {
          currentChild = FadeTransition(
            opacity: animation,
            child: currentChild,
          );
        }

        // إضافة تأثير التكبير إذا كان مفعلاً
        if (useScale) {
          currentChild = ScaleTransition(
            scale: animation,
            child: currentChild,
          );
        }

        // إضافة تأثير الدوران إذا كان مفعلاً
        if (useRotation) {
          currentChild = RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: currentChild,
          );
        }

        // إضافة تأثير الانزلاق إذا كان مفعلاً
        if (useSlide) {
          Offset beginOffset = slideAxis == Axis.horizontal
              ? const Offset(1.0, 0.0) // انزلاق أفقي
              : const Offset(0.0, 1.0); // انزلاق عمودي
          currentChild = SlideTransition(
            position: Tween<Offset>(begin: beginOffset, end: Offset.zero)
                .animate(animation),
            child: currentChild,
          );
        }

        // إرجاع العنصر النهائي مع جميع التأثيرات المفعلة
        return currentChild;
      },
      child: child,
    );
  }
}
//========================================================================================================================================

class AppAnimationList extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool useFade;
  final bool useScale;
  final bool useRotation;
  final bool useSlide;
  final Axis slideAxis;

  const AppAnimationList({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.useFade = true,
    this.useScale = false,
    this.useRotation = false,
    this.useSlide = false,
    this.slideAxis = Axis.horizontal,
  });
  @override
  State<AppAnimationList> createState() => _AppAnimationListState();
}

class _AppAnimationListState extends State<AppAnimationList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..value = 0.0;

    /// run animation after build page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentChild = widget.child;

    if (widget.useFade) {
      currentChild = FadeTransition(
        opacity: _controller,
        child: currentChild,
      );
    }

    if (widget.useScale) {
      currentChild = ScaleTransition(
        scale: _controller,
        child: currentChild,
      );
    }

    if (widget.useRotation) {
      currentChild = RotationTransition(
        turns: Tween<double>(begin: 0.5, end: 1.0).animate(_controller),
        child: currentChild,
      );
    }

    if (widget.useSlide) {
      Offset beginOffset = widget.slideAxis == Axis.horizontal
          ? const Offset(1.0, 0.0)
          : const Offset(0.0, 1.0);
      currentChild = SlideTransition(
        position: Tween<Offset>(begin: beginOffset, end: Offset.zero)
            .animate(_controller),
        child: currentChild,
      );
    }

    return currentChild;
  }
}
