import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';

class DisplayMessage {
  static void _showTopMessage(
    BuildContext context, {
    required String message,
    required Color iconColor,
    required IconData icon,
    required Color borderColor,
    Duration duration = const Duration(seconds: 5),
  }) {
    final overlay = Overlay.of(context);
    final overlayContext = Navigator.of(context);
    final animationController = AnimationController(
      vsync: overlayContext,
      duration: const Duration(milliseconds: 300),
    );

    final animation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewPadding.top - 10,
        left: 16,
        right: 16,
        child: SafeArea(
          child: SlideTransition(
            position: animation,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(10),
              shadowColor: AppColors.defaultColor100,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: iconColor),
                    WidgetsSpacer.horizontalSpacer8,
                    Expanded(
                      child: Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: iconColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    animationController.forward();

    Future.delayed(duration, () async {
      await animationController.reverse();
      if (entry.mounted) entry.remove();
      animationController.dispose();
    });
  }

  static void errorMessage(String message, BuildContext context) {
    _showTopMessage(
      context,
      message: message,
      icon: LineIcons.timesCircleAlt,
      iconColor: AppColors.errorColor,
      borderColor: AppColors.errorColor,
    );
  }

  static void successMessage(String message, BuildContext context) {
    _showTopMessage(
      context,
      message: message,
      icon: LineIcons.checkCircleAlt,
      iconColor: AppColors.primaryColor,
      borderColor: AppColors.primaryColor,
    );
  }
}
