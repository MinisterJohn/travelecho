import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/pages/authorizedPages/trip/set_flight_date.dart';

class SetDestination extends StatefulWidget {
  const SetDestination({super.key});

  @override
  State<SetDestination> createState() => _SetDestinationState();
}

class _SetDestinationState extends State<SetDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4), // Padding inside the circle
            decoration: const BoxDecoration(
              color: Color.fromRGBO(248, 239, 255, 1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LineIcons.arrowLeft,
              color: Colors.black,
              size: 25, // Adjusted icon size for better fit
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Set Destination',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segoe UI',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                "Where to?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              TextField(
                // controller: _currentLocation,
                decoration: InputDecoration(
                  prefixIcon: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(Icons.search, size: 18),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(maxWidth: 40),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14), // Adjusts internal padding
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(8)), // Optional: Adds rounded corners
                  ),
                  hintText: "Enter your location",
                ),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
              ),

              // _nextTravelPlan(),
              const SizedBox(height: 20),
              _recommendedDestinations(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Clear all"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Set your desired border radius
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff930BFF),
                        // minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Set your desired border radius
                        ),
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
        Text(
          "Recommended Destinations",
          style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, .6)),
        ),
        SizedBox(
          height: 20,
        ),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FlightDate()));
          },
          child: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 8,
              ),
              Text(location)
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(height: 2, color: Color.fromRGBO(150, 150, 150, 1)),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
