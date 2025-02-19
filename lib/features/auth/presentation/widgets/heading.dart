// HeadingText.dart
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const HeadingText({
    Key? key,
    required this.text,
    this.fontSize = 32.0,
    this.color = const Color(0xff930BFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
