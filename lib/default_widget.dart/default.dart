import 'package:flutter/material.dart';

class Default extends StatelessWidget {
  final Widget? child;
  final Color color;
  final double width;
  final double height;
  final Alignment contentAlignment;
  final BorderRadius rad;

  const Default({
    super.key,
    this.child,
    this.width = 100,
    this.height = 150,
    this.color = Colors.grey,
    this.contentAlignment = Alignment.center,
    this.rad = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,

      child: Align(
        alignment: contentAlignment,
        child: child,
      ),
    );
  }
}
