import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsCongratsScreen extends StatelessWidget {
  const CarRentalsCongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetsSpacer.verticalSpacer48,
                const Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                WidgetsSpacer.verticalSpacer16,
                const Text(
                  "You just booked your first ride",
                  style: TextStyle(fontSize: 16, color: AppColors.defaultColor),
                  textAlign: TextAlign.center,
                ),
                WidgetsSpacer.verticalSpacer32,
                // Illustration
                Image.asset(
                  "assets/images/car_rentals/congratulation.png", // Replace with your asset path
                  height: 120,
                ),
                WidgetsSpacer.verticalSpacer48,
                // Go back home button
                AppPrimaryButton(
                  child: const Text(
                    "Go  back home",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    // Navigate to home
                    AppNavigator.push (
                          context,
                          const CarRentalsCongratsScreen(),
                    );
                  },
                ),
                WidgetsSpacer.verticalSpacer16,
                // Track ride button (outlined)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: BorderSide(color: AppColors.primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to track ride
                      AppNavigator.push(
                            context,
                            const CarRentalsTrackRideScreen(),
                          );
                    },
                    child: const Text(
                      "Track ride",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
