import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsTrackRideScreen extends StatelessWidget {
  const CarRentalsTrackRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        "Driver is driving",
        context,
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppColors.primaryColor),
            tooltip: "Live Tracking",
            onPressed: () {
              AppNavigator.push(context, const CarRentalsLiveTrackingScreen());
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              children: [
                // Status bar
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.symmetric(vertical: 8),
                //   decoration: BoxDecoration(
                //     color: AppColors.primaryColor,
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: const Center(
                //     child: Text(
                //       "Driver is driving",
                //       style: TextStyle(
                //         color: AppColors.white,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
                WidgetsSpacer.verticalSpacer20,
                // Estimated arrival
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "45 mins",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Estimated arrival. 1.2 miles away",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                WidgetsSpacer.verticalSpacer32,
                // Driver info card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Driver avatar
                          CircleAvatar(
                            radius: 28,
                            // backgroundImage: AssetImage(
                            //   "assets/images/driver_avatar.png", // Replace with your asset
                            // ),
                          ),
                          WidgetsSpacer.horizontalSpacer8,
                          // Driver name and car
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Charlie davidson",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Lexus 350 - Black",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer20,
                      // Pickup info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                              Container(
                                width: 2,
                                height: 22,
                                color: Colors.grey[300],
                              ),
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                            ],
                          ),
                          WidgetsSpacer.horizontalSpacer8,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Pickup : 9:45 AM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Berkely Avenue, New York",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                WidgetsSpacer.verticalSpacer8,
                                Text(
                                  "Dropoff : 2:30 PM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Silicia, Bahamas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer32,
                    ],
                  ),
                ),
                WidgetsSpacer.verticalSpacer48,
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: () {
                          // Share ride logic
                        },
                        child: const Text(
                          "Share Ride",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    WidgetsSpacer.horizontalSpacer16,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: () {
                          // Cancel ride logic
                        },
                        child: const Text(
                          "Cancel Ride",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
