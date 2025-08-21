import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverWalletScreen extends StatelessWidget {
  const DriverWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top colored section
            Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Driver Wallet",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Available balance",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                          ),
                        ),
                        WidgetsSpacer.verticalSpacer8,
                        const Text(
                          "\$230",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        WidgetsSpacer.verticalSpacer8,
                        const Text(
                          "Pending: \$50",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                        WidgetsSpacer.verticalSpacer16,
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  foregroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_forward, size: 18),
                                label: const Text(
                                  "Withdraw",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  // Withdraw logic
                                  AppNavigator.push(
                                    context,
                                    const DriverWithdrawalScreen(),
                                  );
                                },
                              ),
                            ),
                            WidgetsSpacer.horizontalSpacer16,
                            // Withdrawal history button
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.history,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  // Navigate to withdrawal history
                                  AppNavigator.push(
                                    context,
                                    const DriverWithdrawalActivityScreen(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    "Recent activity",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  WidgetsSpacer.spacer,
                  TextButton(
                    onPressed: () {
                      // View all activity
                    },
                    child: const Text(
                      "View all",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WidgetsSpacer.verticalSpacer8,
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _activityTile(
                    "\$50",
                    "Ride",
                    "Today at 2:20 pm",
                    "Completed",
                  ),
                  _activityTile(
                    "\$145",
                    "Ride",
                    "Today at 1:30 pm",
                    "Completed",
                  ),
                  _activityTile(
                    "\$45",
                    "Ride",
                    "Today at 1:30 pm",
                    "Completed",
                  ),
                ],
              ),
            ),
            // Floating button (bottom right)
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 24, right: 24),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: FloatingActionButton(
            //       backgroundColor: AppColors.primaryColor,
            //       onPressed: () {
            //         // Add wallet action
            //       },
            //       child: const Icon(Icons.add, color: AppColors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _activityTile(
    String amount,
    String title,
    String time,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                WidgetsSpacer.verticalSpacer8,
                Text(
                  time,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                WidgetsSpacer.verticalSpacer8,
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
