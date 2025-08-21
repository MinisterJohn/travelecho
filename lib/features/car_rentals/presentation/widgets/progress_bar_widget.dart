import 'package:flutter/material.dart';

class FormProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final Color color;

  const FormProgressBar({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: color.withOpacity(0.15),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}