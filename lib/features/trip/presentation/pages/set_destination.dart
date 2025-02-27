import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/appbar.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/trip/presentation/pages/set_flight_date.dart';

class SetDestination extends StatefulWidget {
  const SetDestination({super.key});

  @override
  State<SetDestination> createState() => _SetDestinationState();
}

class _SetDestinationState extends State<SetDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Trip Destination", context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsSpacer.verticalSpacer16,
              const Text(
                "Where to?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              WidgetsSpacer.verticalSpacer8,

              const TextField(
                // controller: _currentLocation,
                decoration: InputDecoration(
                  prefixIcon: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(Icons.search, size: 18),
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

              // _nextTravelPlan(),
              WidgetsSpacer.verticalSpacer16,

              _recommendedDestinations(),
              WidgetsSpacer.verticalSpacer16,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Clear all")),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
              // _location()
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendedDestinations() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended Destinations",
          style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, .6)),
        ),
        WidgetsSpacer.verticalSpacer16,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _recommendedDestination("Italy"),
            _recommendedDestination("Germany"),
            _recommendedDestination("United States of America"),
            _recommendedDestination("London"),
          ],
        )
      ],
    );
  }

  Widget _recommendedDestination(String location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppNavigator.push(context, const FlightDate());
          },
          child: Row(
            children: [
              const Icon(Icons.location_on),
              WidgetsSpacer.horinzontalSpacer8,
              Text(location)
            ],
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        const Divider(height: 2, color: AppColors.secondaryColor),
        WidgetsSpacer.verticalSpacer8,
      ],
    );
  }
}
