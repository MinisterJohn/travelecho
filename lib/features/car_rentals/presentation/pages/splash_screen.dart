import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsSplashScreen extends StatelessWidget {
  const CarRentalsSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'LUXURIOUS,\nEFFICIENT RIDES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            // Car image
            SizedBox(
              // padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Image.asset(
                'assets/images/car_rentals/car_rentals.png',
                fit: BoxFit.contain,
                height: 300,
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Cut the Stress of boarding a Taxi\nwith one click',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: AppPrimaryButton(
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  // Your logic here
                  AppNavigator.push(
                    context,
                    // Scaffold(body: const Center(child: Text("Car Rentals feature coming soon!"))),
                    const CarRentalsUserDriverOptions(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
