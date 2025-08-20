import 'package:flutter/material.dart';
import '../../../features_exports.dart';

enum NotificationState {
  hasNotifications,
  noNotifications,
  offline,
  allCaughtUp,
}

class DriverNotificationScreen extends StatefulWidget {
  const DriverNotificationScreen({super.key});

  @override
  State<DriverNotificationScreen> createState() =>
      _DriverNotificationScreenState();
}

class _DriverNotificationScreenState extends State<DriverNotificationScreen> {
  NotificationState notificationState = NotificationState.noNotifications;

  // Example notification data
  final List<String> notifications = [
    "Sarah Hookes just cancelled her ride",
    "We're currently experiencing some technical issues",
    "Trip cancelled: Victor King has cancelled his pickup at Plot A. You won't be charged for this.",
  ];

  // Track expanded state for each notification
  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();
    expandedList = List.generate(notifications.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (notificationState) {
      case NotificationState.hasNotifications:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetsSpacer.verticalSpacer32,
            const Text(
              "Notification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.defaultColor,
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            ...List.generate(notifications.length, (index) {
              final isExpanded = expandedList[index];
              final text = notifications[index];
              final maxLines = isExpanded ? null : 1;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.defaultColor100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: maxLines,
                        overflow:
                            isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black54,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          expandedList[index] = !expandedList[index];
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
        break;
      case NotificationState.noNotifications:
        content = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/no_notifications.png",
                width: 72,
                height: 72,
              ),
              // WidgetsSpacer.verticalSpacer16,
              // const Text(
              //   "No Notifications",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //     color: AppColors.defaultColor,
              //   ),
              // ),
              // WidgetsSpacer.verticalSpacer8,
              // const Text(
              //   "You're all up to date.",
              //   style: TextStyle(color: Colors.black54, fontSize: 14),
              // ),
            ],
          ),
        );
        break;
      case NotificationState.offline:
        content = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/offline_background.png",
                width: 72,
                height: 72,
              ),
              WidgetsSpacer.verticalSpacer16,
              // const Text(
              //   "You're Offline",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //     color: AppColors.defaultColor,
              //   ),
              // ),
              // WidgetsSpacer.verticalSpacer8,
              // const Text(
              //   "Check your connection to receive bookings.",
              //   style: TextStyle(color: Colors.black54, fontSize: 14),
              // ),
              // WidgetsSpacer.verticalSpacer20,
              SizedBox(
                width: 120,
                child: AppPrimaryButton(
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: 10,
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    // Retry logic here
                  },
                ),
              ),
            ],
          ),
        );
        break;
      case NotificationState.allCaughtUp:
        content = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/all_caughtup_background.png",
                width: 72,
                height: 72,
              ),
              WidgetsSpacer.verticalSpacer16,
              // const Text(
              //   "All Caught Up!",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //     color: AppColors.defaultColor,
              //   ),
              // ),
              // WidgetsSpacer.verticalSpacer8,
              // const Text(
              //   "You don't have any new alerts.",
              //   style: TextStyle(color: Colors.black54, fontSize: 14),
              // ),
            ],
          ),
        );
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: setAppBar("", context),
      body: SafeArea(
        child: Padding(padding: WidgetsSpacer.pagePadding, child: content),
      ),
    );
  }
}
