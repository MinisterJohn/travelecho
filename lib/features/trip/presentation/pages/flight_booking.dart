import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/trip/presentation/pages/set_destination.dart';
import 'package:travelecho/features/trip/presentation/pages/set_flight_date.dart';
import 'package:travelecho/features/trip/presentation/pages/trip_notification.dart';
import 'package:travelecho/core/constants/appbar.dart';

class FlightBooking extends StatefulWidget {
  const FlightBooking({super.key});

  @override
  State<FlightBooking> createState() => _FlightBookingState();
}

class _FlightBookingState extends State<FlightBooking> {
  int adults = 0;
  int children = 0;
  int infants = 0;
  int pets = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Flight Booking", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  AppNavigator.push(context, const SetDestination());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 70),
                  backgroundColor:
                      Colors.white, // Ensure a strong white background
                  foregroundColor: Colors.black, // Text and icon color
                  elevation: 1.0, // Shadow intdow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Next destination",
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                        ),
                        Text(
                          "Germany, Munich",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  AppNavigator.push(context, const FlightDate());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 70),
                  backgroundColor:
                      Colors.white, // Ensure a strong white background
                  foregroundColor: Colors.black, // Text and icon color
                  elevation: 1.0, // Shadow intdow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "When is your trip?",
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 14,
                        ),
                        Text(
                          "Sat, 14th Sept. 2024",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // _nextTravel
              // Plan(),
              WidgetsSpacer.verticalSpacer16,
              _peopleComing(),
              WidgetsSpacer.verticalSpacer16,

              ElevatedButton(
                onPressed: () {
                  AppNavigator.push(context, TripNotification());
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
              // _location()
            ],
          ),
        ),
      ),
    );
  }

  Widget _setofpeople(String category, String category_description, int value,
      VoidCallback onIncrement, VoidCallback onDecrement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 1),
                Text(
                  category_description,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 0, 0, .5)),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: const Icon(LineIcons.minusSquare),
                ),
                const SizedBox(width: 4),
                Text(
                  "$value",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(LineIcons.plusSquare),
                ),
              ],
            )
          ],
        ),
        WidgetsSpacer.verticalSpacer8,
        Divider(height: 2, color: AppColors.defaultColor100),
        WidgetsSpacer.verticalSpacer8,
      ],
    );
  }

  Widget _peopleComing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Who is coming?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _setofpeople(
              "Adult",
              "From 13 years and Above",
              adults,
              () {
                setState(() {
                  adults += 1;
                });
              },
              () {
                setState(() {
                  if (adults > 0) adults -= 1; // Prevent negative values
                });
              },
            ),
            _setofpeople(
              "Children",
              "Age 2 - 12 years",
              children,
              () {
                setState(() {
                  children += 1;
                });
              },
              () {
                setState(() {
                  if (children > 0) children -= 1;
                });
              },
            ),
            _setofpeople(
              "Infants",
              "Under 2 years",
              infants,
              () {
                setState(() {
                  infants += 1;
                });
              },
              () {
                setState(() {
                  if (infants > 0) infants -= 1;
                });
              },
            ),
            _setofpeople(
              "Pets",
              "Are you bringing a service animal?",
              pets,
              () {
                setState(() {
                  pets += 1;
                });
              },
              () {
                setState(() {
                  if (pets > 0) pets -= 1;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
