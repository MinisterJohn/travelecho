import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/trip/presentation/pages/set_destination.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final TextEditingController _currentLocation =
      TextEditingController(text: "Lagos, Nigeria");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Trip", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nextTravelPlan(),
              WidgetsSpacer.verticalSpacer16,
              _location()
            ],
          ),
        ),
      ),
    );
  }

  Widget _nextTravelPlan() {
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
            _travelUtils("flights.png", "Flights"),
                   WidgetsSpacer.verticalSpacer8,

            _travelUtils("hotels.png", "Hotels"),
                    WidgetsSpacer.verticalSpacer8,

            _travelUtils("car_rentals.png", "Car Rentals"),
          ],
        ),
      ],
    );
  }

  Widget _travelUtils(String imageurl, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.defaultColor400, width: 2),
          borderRadius: BorderRadius.circular(5),
          // color: Color.fromRGBO(248, 248, 248, 1)
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.defaultColor400,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/trip_images/$imageurl",
                width: 40, // Adjust size of the emoji
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

  Widget _location() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.1), // Optional: Adjust shadow color
            blurRadius: 2, // Spread of the shadow blur
            offset: const Offset(0, 2), // Optional: Adjusts the shadow position
          ),
        ],
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns text to the start
          children: [
            const Text(
              "Current location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8), // Adds space between text and text field
            TextField(
              controller: _currentLocation,
              decoration: const InputDecoration(
                prefixIcon: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child:
                        FaIcon(FontAwesomeIcons.locationCrosshairs, size: 18),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(maxWidth: 40),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 14), // Adjusts internal padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)), // Optional: Adds rounded corners
                ),
                hintText: "Enter your location",
              ),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
                height: 16), // Adds space between text and text field
            OutlinedButton(
                onPressed: () {
                  AppNavigator.push(context, const SetDestination());
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Set your desired border radius
                  ),
                ),
                child: const Text("Select Destination"))
          ],
        ),
      ),
    );
  }
}
