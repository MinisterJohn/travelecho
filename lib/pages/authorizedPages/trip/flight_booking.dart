import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/pages/authorizedPages/trip/set_destination.dart';
import 'package:travelecho/pages/authorizedPages/trip/set_flight_date.dart';
import 'package:travelecho/pages/authorizedPages/trip/trip_notification.dart';
import 'package:travelecho/reuseable_widgets/colors.dart';

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
          'Flight Booking',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segoe UI',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetDestination()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 70),
                  backgroundColor:
                      Colors.white, // Ensure a strong white background
                  foregroundColor: Colors.black, // Text and icon color
                  elevation: 1.0, // Shadow intdow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Next destination",
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                        ),
                        Text(
                          "Germany, Munich",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlightDate()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 70),
                  backgroundColor:
                      Colors.white, // Ensure a strong white background
                  foregroundColor: Colors.black, // Text and icon color
                  elevation: 1.0, // Shadow intdow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                  ),
                ),
                child: Row(
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
              const SizedBox(height: 20),
              _peopleComing(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripNotification()));
                },
                child: Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Set your desired border radius
                  ),
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
                Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 1),
                Text(
                  category_description,
                  style: TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 0, 0, .5)),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: Icon(LineIcons.minusSquare),
                ),
                SizedBox(width: 4),
                Text(
                  "$value",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 4),
                IconButton(
                  onPressed: onIncrement,
                  icon: Icon(LineIcons.plusSquare),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Divider(height: 2, color: Color.fromRGBO(150, 150, 150, 1)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _peopleComing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who is coming?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
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
