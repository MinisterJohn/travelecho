import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TravelUtils(
              imageUrl: "flights.png",
              label: "Flights",
              onTap: () {
                // Navigate to flight booking
                AppNavigator.push(
                  context,
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: sl<FlightBookingBloc>()),
                    ],
                    child: const FlightBooking(),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            _TravelUtils(
              imageUrl: "hotels.png",
              label: "Hotels",
              onTap: () {
                // Navigate to hotel booking
                AppNavigator.push(
                  context,
                  BlocProvider(
                    create: (context) => sl<HotelBookingBloc>(),
                    child: const HotelBooking(),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            _TravelUtils(
              imageUrl: "car_rentals.png",
              label: "Car Rentals",
              onTap: () {
                // Car rental functionality will be added later
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _TravelUtils extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  const _TravelUtils({
    required this.imageUrl,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
              const SizedBox(height: 16),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
