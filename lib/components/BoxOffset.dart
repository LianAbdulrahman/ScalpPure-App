import 'package:flutter/material.dart';

class GetBoxOffset extends StatefulWidget {
  final Widget child;
  final Function(Offset offset) offset;

  const GetBoxOffset({
    super.key,
    required this.child,
    required this.offset,
  });

  @override
  GetBoxOffsetState createState() => GetBoxOffsetState();
}

class GetBoxOffsetState extends State<GetBoxOffset> {
  GlobalKey widgetKey = GlobalKey();
  RenderBox? box;
  Offset offset = const Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      box = widgetKey.currentContext?.findRenderObject() as RenderBox?;
      offset = box!.localToGlobal(offset);
      widget.offset(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }
}
