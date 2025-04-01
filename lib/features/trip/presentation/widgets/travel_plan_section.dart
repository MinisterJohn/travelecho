import 'package:flutter/material.dart';
import '../../trip_exports.dart';

class TravelPlanSection extends StatelessWidget {
  const TravelPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Plan your next travel",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TravelUtils(imageUrl: "flights.png", label: "Flights"),
            WidgetsSpacer.horinzontalSpacer8,
            _TravelUtils(imageUrl: "hotels.png", label: "Hotels"),
            WidgetsSpacer.horinzontalSpacer8,
            _TravelUtils(imageUrl: "car_rentals.png", label: "Car Rentals"),
          ],
        ),
      ],
    );
  }
}

class _TravelUtils extends StatelessWidget {
  final String imageUrl;
  final String label;

  const _TravelUtils({
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.defaultColor100, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.defaultColor100,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/trip_images/$imageUrl",
                width: 40,
              ),
            ),
            WidgetsSpacer.verticalSpacer16,
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
