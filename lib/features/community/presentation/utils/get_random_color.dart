import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomRgbaColor(String? name) {
  if (name == null || name.isEmpty) {
    return const Color.fromRGBO(158, 158, 158, 1); // Default gray
  }

  final hash = name.codeUnits.fold(0, (prev, elem) => prev + elem);
  final random = Random(hash);

  // 🎨 RGBA palette (including purple as primary)
  final rgbaColors = [
    const Color.fromRGBO(156, 39, 176, 1),   // Purple (Primary)
    const Color.fromRGBO(244, 67, 54, 1),    // Red
    const Color.fromRGBO(33, 150, 243, 1),   // Blue
    const Color.fromRGBO(76, 175, 80, 1),    // Green
    const Color.fromRGBO(255, 152, 0, 1),    // Orange
    const Color.fromRGBO(233, 30, 99, 1),    // Pink
    const Color.fromRGBO(0, 188, 212, 1),    // Cyan
    const Color.fromRGBO(121, 85, 72, 1),    // Brown
    const Color.fromRGBO(205, 220, 57, 1),   // Lime
    const Color.fromRGBO(63, 81, 181, 1),    // Indigo
  ];

  return rgbaColors[random.nextInt(rgbaColors.length)];
}