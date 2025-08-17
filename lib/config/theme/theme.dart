import 'package:flutter/material.dart' hide CarouselController;
import '../../core/core_exports.dart';

export 'app_theme.dart';
export 'dark_theme.dart';

class AppTheme {
  static final appTheme = AppThemeData.appTheme;
  static final darkTheme = DarkThemeData.darkTheme;
}

ButtonStyle mergeWithThemeButtonStyle(BuildContext context, ButtonStyle extra) {
  return Theme.of(context).elevatedButtonTheme.style?.merge(extra) ?? extra;
}

ButtonStyle mergeWithTextThemeButtonStyle(
  BuildContext context,
  ButtonStyle extra,
) {
  return Theme.of(context).textButtonTheme.style?.merge(extra) ?? extra;
}
