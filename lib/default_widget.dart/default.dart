import 'package:flutter/material.dart';

class Default extends StatelessWidget {
  final String? text;
  final Color color;
  final double width;
  final double height;
  final Alignment contentAlignment;

  const Default({
    super.key,
    this.text,
    this.width = 100,
    this.height = 250,
    this.color = Colors.grey,
    this.contentAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      child: Align(
        alignment: contentAlignment,
        child: Text(text ?? ''),
      ),
    );
  }
}
