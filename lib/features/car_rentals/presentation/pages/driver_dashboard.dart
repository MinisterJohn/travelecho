import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  bool isOnline = false;
  bool hideEarnings = false;
  bool showBookingPopup = false;

  final List<Map<String, dynamic>> bookings = [
    {
      "name": "Sarah Davids",
      "location": "Terminal A to Zannis Hotels and suites",
      "time": "2:00 PM",
      "confirmed": true,
    },
    {
      "name": "Victoria Park",
      "location": "Terminal B to Ideal suites",
      "time": "2:00 PM",
      "confirmed": true,
    },
    {
      "name": "Mary Copeland",
      "location": "Terminal B to Minnesota",
      "time": "4:30 PM",
      "confirmed": false,
    },
  ];

  Map<String, dynamic> newBooking = {
    "from": "Berkely Avenue, New York",
    "to": "Silicia, Bahamas",
    "time": "8:00 AM GMT",
    "date": "27th August, 2025",
    "class": "Business Class",
    "price": "\$49.99",
  };

  @override
  Widget build(BuildContext context) {
    Widget? bookingBanner;
    if (showBookingPopup == false && newBooking.isNotEmpty) {
      bookingBanner = GestureDetector(
        onTap: () {
          setState(() {
            showBookingPopup = true;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.notifications, color: Colors.white),
              WidgetsSpacer.horizontalSpacer8,
              const Expanded(
                child: Text(
                  "You have new booking",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: WidgetsSpacer.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetsSpacer.verticalSpacer32,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      // backgroundImage: AssetImage("assets/images/driver_avatar.png"),
                    ),
                    WidgetsSpacer.horizontalSpacer8,
                    const Text(
                      "Welcome John 👋",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    WidgetsSpacer.spacer,
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        AppNavigator.push(
                          context,
                          const DriverNotificationScreen(),
                        );
                      },
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,
                // Earnings Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9F5CFF), Color(0xFF6E56FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                hideEarnings = !hideEarnings;
                              });
                            },
                            child: Icon(
                              hideEarnings
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          WidgetsSpacer.horizontalSpacer8,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Earnings today",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  hideEarnings ? "******" : "\$230",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          WidgetsSpacer.horizontalSpacer20,

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Earnings",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  hideEarnings ? "******" : "\$6000",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                context,
                                const DriverWalletScreen(),
                              );
                            },
                            child: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 28,
                          ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                WidgetsSpacer.verticalSpacer20,
                Row(
                  children: [
                    const Text(
                      "Driver Status",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    WidgetsSpacer.horizontalSpacer16,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.green[50] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        isOnline ? "Online" : "Offline",
                        style: TextStyle(
                          color: isOnline ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    WidgetsSpacer.horizontalSpacer8,
                    Switch(
                      value: isOnline,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      onChanged: (val) {
                        setState(() {
                          isOnline = val;
                        });
                      },
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,
                const Text(
                  "Today's Bookings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                WidgetsSpacer.verticalSpacer8,
                Column(
                  children:
                      bookings.map((booking) {
                        final bool confirmed = booking["confirmed"] as bool;
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  confirmed
                                      ? AppColors.primaryColor
                                      : Colors.grey[300]!,
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              WidgetsSpacer.verticalSpacer8,
                              Text(
                                booking["location"],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                              WidgetsSpacer.verticalSpacer8,
                              Text(
                                "Time: ${booking["time"]}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                              WidgetsSpacer.verticalSpacer8,
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          confirmed
                                              ? AppColors.primaryColor100
                                              : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      confirmed ? "Confirmed" : "Unconfirmed",
                                      style: TextStyle(
                                        color:
                                            confirmed
                                                ? AppColors.primaryColor
                                                : Colors.orange,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  WidgetsSpacer.spacer,
                                  SizedBox(
                                    width: 100,
                                    child: AppPrimaryButton(
                                      borderRadius: 10,
                                      height: 36,
                                      onPressed:
                                          confirmed
                                              ? () {
                                                // Start ride logic
                                              }
                                              : null,
                                      backgroundColor:
                                          confirmed
                                              ? AppColors.primaryColor
                                              : AppColors.primaryColor.withOpacity(
                                                0.4,
                                              ),
                                      child: Text(
                                        "Start ride",
                                        style: TextStyle(
                                          color:
                                              confirmed
                                                  ? Colors.white
                                                  : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
                // WidgetsSpacer.verticalSpacer32,
                // Center(
                //   child: SizedBox(
                //     width: 160,
                //     child: AppPrimaryButton(
                //       borderRadius: 10,
                //       height: 44,
                //       backgroundColor: AppColors.primaryColor,
                //       child: const Text(
                //         "Confirm",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 16,
                //         ),
                //       ),
                //       onPressed: () {
                //         // Confirm logic
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          if (bookingBanner != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: bookingBanner,
            ),
          if (showBookingPopup)
            DriverBookingPopup(
              booking: newBooking,
              onConfirm: () {
                setState(() {
                  showBookingPopup = false;
                  // Approve booking logic here
                  newBooking.clear();
                });
              },
              onClose: () {
                setState(() {
                  showBookingPopup = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
