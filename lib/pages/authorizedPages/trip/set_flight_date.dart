import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/pages/authorizedPages/trip/flight_booking.dart';
import 'package:travelecho/pages/authorizedPages/trip/set_destination.dart';
import 'package:travelecho/reuseable_widgets/colors.dart';
import 'dart:math';

class FlightDate extends StatefulWidget {
  const FlightDate({super.key});

  @override
  State<FlightDate> createState() => _FlightDateState();
}

class _FlightDateState extends State<FlightDate> {
  String _tripDurationBy = "date";
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
          'Flight Date',
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
              const SizedBox(
                height: 30,
              ),
              // CircularMonthSelector(
              //   maxMonths: 12,
              //   onMonthsChanged: (months) {
              //     print("months");
              //   },
              // ),
              TripDaysSelection(),
              // _nextTravelPlan(),
              const SizedBox(height: 20),
              // _recommendedDestinations(),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlightBooking()));
                      },
                      child: Text(
                        "Next",
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

  Widget _tripDaysSelection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "When is your trip?",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 14,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text("Date", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff930BFF),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text("Month", style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: double.infinity,
        height: 400,
        child: RangeDatePicker(
          centerLeadingDate: true,
          currentDate: DateTime.now(), // Set to today's date
          minDate: DateTime.now(), // Minimum selectable date is today
          maxDate: DateTime(2050, 10, 30),
          currentDateDecoration: BoxDecoration(
              shape: BoxShape.rectangle, // Square shape
              borderRadius:
                  BorderRadius.circular(6), // Optional for rounded square
              border: Border.all(width: 1, color: primaryColor)),
          singleSelectedCellDecoration: BoxDecoration(
            color: primaryColor, // Highlight color
            shape: BoxShape.rectangle, // Square shape
            borderRadius:
                BorderRadius.circular(6), // Optional for rounded square
          ), // Maximum selectable date
          onRangeSelected: (value) {
            // Handle selected range
            print("Selected range: ${value.start} - ${value.end}");
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("How many days will you like to stay"),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(LineIcons.minusSquare)),
              SizedBox(
                width: 8,
              ),
              Text("01"),
              SizedBox(
                width: 8,
              ),
              IconButton(onPressed: () {}, icon: Icon(LineIcons.plusSquare))
            ],
          )
        ],
      )
    ]);
  }
}

class TripDaysSelection extends StatefulWidget {
  @override
  _TripDaysSelectionState createState() => _TripDaysSelectionState();
}

class _TripDaysSelectionState extends State<TripDaysSelection> {
  DateTimeRange selectedRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  int getNumberOfDays() {
    return selectedRange.end.difference(selectedRange.start).inDays + 1;
  }

  void incrementRange() {
    setState(() {
      selectedRange = DateTimeRange(
        start: selectedRange.start,
        end: selectedRange.end.add(Duration(days: 1)),
      );
    });
  }

  void decrementRange() {
    if (getNumberOfDays() > 1) {
      setState(() {
        selectedRange = DateTimeRange(
          start: selectedRange.start,
          end: selectedRange.end.subtract(Duration(days: 1)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "When is your trip?",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 14,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text("Date", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff930BFF),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text("Month", style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: double.infinity,
        height: 400,
        child: RangeDatePicker(
          centerLeadingDate: true,
          currentDate: DateTime.now(),
          minDate: DateTime.now(),
          maxDate: DateTime(2050, 10, 30),
          enabledCellsTextStyle: TextStyle(fontSize: 14),
          currentDateTextStyle: TextStyle(fontSize: 14, color: primaryColor),
          singleSelectedCellTextStyle:
              TextStyle(fontSize: 14, color: Colors.white),
          selectedCellsTextStyle: TextStyle(
            fontSize: 14,
          ),
          disabledCellsTextStyle:
              TextStyle(fontSize: 14, color: Color.fromRGBO(200, 200, 200, 1)),
          currentDateDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: primaryColor),
          ),
          singleSelectedCellDecoration: BoxDecoration(
            color: Color(0xff930BFF),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
          ),
          onRangeSelected: (value) {
            setState(() {
              selectedRange = value; // Update the selected range
            });
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("How many days will you like to stay?"),
          Row(
            children: [
              IconButton(
                onPressed: decrementRange,
                icon: Icon(LineIcons.minusSquare),
              ),
              SizedBox(width: 4),
              Text(
                "${getNumberOfDays()}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 4),
              IconButton(
                onPressed: incrementRange,
                icon: Icon(LineIcons.plusSquare),
              ),
            ],
          )
        ],
      ),
    ]);
  }
}

class CircularMonthSelector extends StatefulWidget {
  final int maxMonths;
  final int initialMonths;
  final Function(int months) onMonthsChanged;

  const CircularMonthSelector({
    Key? key,
    required this.maxMonths,
    this.initialMonths = 1,
    required this.onMonthsChanged,
  }) : super(key: key);

  @override
  _CircularMonthSelectorState createState() => _CircularMonthSelectorState();
}

class _CircularMonthSelectorState extends State<CircularMonthSelector> {
  late int selectedMonths;
  late Offset center;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    selectedMonths = widget.initialMonths;
  }

  void _updateSelectedMonths(Offset touchPosition) {
    final double dx = touchPosition.dx - center.dx;
    final double dy = touchPosition.dy - center.dy;
    final double radians = atan2(dy, dx);

    // Normalize radians to a 0-360 degree angle
    angle = (radians + pi) % (2 * pi);
    final int months = (angle / (2 * pi) * widget.maxMonths).round();

    setState(() {
      selectedMonths = max(1, months);
      widget.onMonthsChanged(selectedMonths);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = min(constraints.maxWidth, constraints.maxHeight);
        final double radius = size / 2 - 20;

        return GestureDetector(
          onPanStart: (details) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            center = renderBox.localToGlobal(Offset(size / 2, size / 2));
          },
          onPanUpdate: (details) {
            _updateSelectedMonths(details.localPosition);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Circle
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
              ),
              // Progress Indicator
              Positioned.fill(
                child: CustomPaint(
                  painter: CircularProgressPainter(
                    progressAngle: angle,
                    totalAngle: 2 * pi,
                    color: Colors.blue,
                  ),
                ),
              ),
              // Inner Circle
              Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$selectedMonths",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Months",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progressAngle;
  final double totalAngle;
  final Color color;

  CircularProgressPainter({
    required this.progressAngle,
    required this.totalAngle,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
