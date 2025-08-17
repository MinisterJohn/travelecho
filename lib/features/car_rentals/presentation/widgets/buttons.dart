import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class AppPrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed; // Allow null
  final Color backgroundColor;
  final double borderRadius;
  final double height;

  const AppPrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.borderRadius = 24,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled
                  ? backgroundColor
                  : backgroundColor.withOpacity(0.5), // Dim when disabled
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed, // Will be null if disabled
        child: child,
      ),
    );
  }
}

class EditIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const EditIconButton({
    super.key,
    required this.onPressed,
    this.size = 18,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit, size: size, color: color),
      onPressed: onPressed,
      splashRadius: size + 6,
      tooltip: 'Edit',
    );
  }
}
