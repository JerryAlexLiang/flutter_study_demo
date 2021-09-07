import 'package:flutter/material.dart';

class NinePointBox extends StatelessWidget {
  final ImageProvider image;
  final Widget child;
  final Rect sliceRect;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;

  NinePointBox({
    Key key,
    @required this.image,
    this.child,
    @required this.sliceRect,
    this.padding,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            centerSlice: sliceRect,
            image: image,
          ),
        ),
        padding: padding,
        margin: margin,
        child: child,
      ),
      onTap: onTap,
    );
  }
}
