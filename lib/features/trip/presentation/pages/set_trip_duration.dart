import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:math';
import '../../trip_exports.dart';

class TripDuration extends StatefulWidget {
  const TripDuration({super.key});

  @override
  State<TripDuration> createState() => _TripDurationState();
}

class _TripDurationState extends State<TripDuration> {
  final String _tripDurationBy = "date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Flight Date", context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _progressDisplay(),
              WidgetsSpacer.verticalSpacer16,
              const TripDaysSelection(),
              WidgetsSpacer.verticalSpacer16,
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           context.read<FlightBookingBloc>().clearBooking();
              //         },
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: const Text("Clear all"),
              //       ),
              //       ElevatedButton(
              //         onPressed: () {
              //           AppNavigator.push(context, const FlightBooking());
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: const Color(0xff930BFF),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: const Text(
              //           "Next",
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //     ],
              //   )
            ],
          ),
        ),
      ),
      bottomNavigationBar: DestinationBottomBar(onClear: () {
        // context.read<AirportBloc>().add(ClearAirportSearch());
      }, onNext: () {
        AppNavigator.push(
            context,
            BlocProvider.value(
                value: sl<FlightBookingBloc>(), child: const FlightBooking()));
      }),
    );
  }
}

Widget _progressDisplay() {
  return BlocBuilder<FlightBookingBloc, FlightBookingState>(
      builder: (context, state) {
    if (state is FlightBookingSuccess) {
      final originDestination = state.flightBooking.originDestinations.first;
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            TripProgressDisplay(
                progressIcon: Icons.flight_takeoff_outlined,
                progressKey: "Origin Airport",
                progressValue: originDestination.originLocationCode,
                onPressed: () {
                  AppNavigator.push(
                      context,
                      BlocProvider.value(
                          value: sl<FlightBookingBloc>(),
                          child: const TripScreen()));
                }),
            WidgetsSpacer.horinzontalSpacer8,
            TripProgressDisplay(
                progressIcon: Icons.flight_land_outlined,
                progressKey: "Destination Airport",
                progressValue: originDestination.destinationLocationCode,
                onPressed: () {
                  AppNavigator.push(
                      context,
                      BlocProvider.value(
                          value: sl<FlightBookingBloc>(),
                          child: const SetDestination()));
                }),
          ]));
    }
    return const SizedBox.shrink();
  });
}

class TripDaysSelection extends StatefulWidget {
  const TripDaysSelection({super.key});

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
        end: selectedRange.end.add(const Duration(days: 1)),
      );
      _onDateRangeSelected(selectedRange);
    });
  }

  void decrementRange() {
    if (getNumberOfDays() > 1) {
      setState(() {
        selectedRange = DateTimeRange(
          start: selectedRange.start,
          end: selectedRange.end.subtract(const Duration(days: 1)),
        );
        _onDateRangeSelected(selectedRange);
      });
    }
  }

  void _onDateRangeSelected(DateTimeRange range) {
    if (context.mounted) {
      final flightBookingBloc = context.read<FlightBookingBloc>();
      final currentBooking = flightBookingBloc.flightBooking;

      if (currentBooking.originDestinations.isNotEmpty) {
        final originDestination = currentBooking.originDestinations.first;
        final updatedOriginDestination = OriginDestination(
          id: originDestination.id,
          originLocationCode: originDestination.originLocationCode,
          originLocationName: originDestination.originLocationName,
          destinationLocationCode: originDestination.destinationLocationCode,
          destinationLocationName: originDestination.destinationLocationName,
          departureDateTimeRange: DepartureDateTimeRange(
            date:
                "${range.start.year}-${range.start.month.toString().padLeft(2, '0')}-${range.start.day.toString().padLeft(2, '0')}",
            time:
                "${range.start.hour.toString().padLeft(2, '0')}:${range.start.minute.toString().padLeft(2, '0')}",
          ),
        );

        flightBookingBloc.add(UpdateFlightBooking(
          updateKey: FlightBookingUpdateKey.originDestination,
          updateValue: updatedOriginDestination,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "When is your trip?",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff930BFF),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Date", style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Month", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
      SizedBox(
        width: double.infinity,
        height: 400,
        child: RangeDatePicker(
          centerLeadingDate: true,
          initialDate: DateTime.now(),
          minDate: DateTime.now(),
          maxDate: DateTime(2050, 10, 30),
          enabledCellsTextStyle: const TextStyle(fontSize: 14),
          currentDateTextStyle:
              const TextStyle(fontSize: 14, color: AppColors.primaryColor),
          singleSelectedCellTextStyle:
              const TextStyle(fontSize: 14, color: Colors.white),
          selectedCellsTextStyle: const TextStyle(fontSize: 14),
          disabledCellsTextStyle: const TextStyle(
              fontSize: 14, color: Color.fromRGBO(200, 200, 200, 1)),
          currentDateDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: AppColors.primaryColor),
          ),
          singleSelectedCellDecoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
          ),
          onRangeSelected: (value) {
            setState(() {
              selectedRange = value;
            });
            _onDateRangeSelected(value);
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("How many days will you like to stay?"),
          Row(
            children: [
              IconButton(
                onPressed: decrementRange,
                icon: const Icon(LineIcons.minusSquare),
              ),
              const SizedBox(width: 4),
              Text(
                "${getNumberOfDays()}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: incrementRange,
                icon: const Icon(LineIcons.plusSquare),
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
    super.key,
    required this.maxMonths,
    this.initialMonths = 1,
    required this.onMonthsChanged,
  });

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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$selectedMonths",
                        style: const TextStyle(
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
