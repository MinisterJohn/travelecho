import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsLiveTrackingScreen extends StatelessWidget {
  const CarRentalsLiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Live Tracking", context),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            // Map background (replace with your map widget)
            Positioned.fill(
              child: Container(
                color: Colors.grey[200],
                // child: Image.asset(
                //   "assets/images/map_placeholder.png", // Replace with your map asset or widget
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            // Top overlay
            Column(
              children: [
                // Live Tracking status
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 32,
                //     vertical: 12,
                //   ),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 6),
                //     decoration: BoxDecoration(
                //       color: AppColors.primaryColor,
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //     child: const Center(
                //       child: Text(
                //         "Live Tracking",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                WidgetsSpacer.verticalSpacer20,
                // Route Progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Route Progress",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "33%",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      Row(
                        children: [
                          const Text(
                            "Pickup",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const Spacer(),
                          const Text(
                            "Destination",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: 0.33,
                        minHeight: 6,
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.15,
                        ),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                ),
                WidgetsSpacer.verticalSpacer20,
                // Map area with tracking icon
                Expanded(
                  child: Stack(
                    children: [
                      // Centered tracking icon
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: const Icon(
                            Icons.navigation,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      // Bottom driver info card
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            bottom: 0,
                            left: 0,
                            right: 0,
                          ),
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(28),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    // backgroundImage: AssetImage(
                                    //   "assets/images/driver_avatar.png", // Replace with your asset
                                    // ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Charlie davidson",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Lexus 350 - Black",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.phone,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      // Call driver logic
                                      AppNavigator.push(context, const CarRentalsCallScreen());
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.message,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      // Message driver logic
                                      AppNavigator.push(context, const CarRentalsMessagingScreen());
                                    },
                                  ),
                                ],
                              ),
                              WidgetsSpacer.verticalSpacer20,
                              Row(
                                children: const [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "45 mins",
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "ETA",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "1.2 miles",
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Distance",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
