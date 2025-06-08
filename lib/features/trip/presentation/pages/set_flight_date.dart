import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../trip_exports.dart';

class FlightDate extends StatefulWidget {
  const FlightDate({super.key});

  @override
  State<FlightDate> createState() => _FlightDateState();
}

class _FlightDateState extends State<FlightDate> {
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
      bottomNavigationBar: DestinationBottomBar(
        onClear: () {
          // context.read<AirportBloc>().add(ClearAirportSearch());
        },
        onNext: () {
          AppNavigator.push(
            context,
            BlocProvider.value(
              value: sl<FlightBookingBloc>(),
              child: const FlightBooking(),
            ),
          );
        },
      ),
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
          child: Row(
            children: [
              TripProgressDisplay(
                progressIcon: Icons.flight_takeoff_outlined,
                progressKey: "Origin Airport",
                progressValue: originDestination.originLocationCode,
                onPressed: () {
                  AppNavigator.push(
                    context,
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: sl<AirportBloc>()),
                        BlocProvider.value(value: sl<FlightBookingBloc>()),
                      ],
                      child: const TripScreen(),
                    ),
                  );
                },
              ),
              WidgetsSpacer.horizontalSpacer8,
              TripProgressDisplay(
                progressIcon: Icons.flight_land_outlined,
                progressKey: "Destination Airport",
                progressValue: originDestination.destinationLocationCode,
                onPressed: () {
                  AppNavigator.push(
                    context,
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: sl<AirportBloc>()),
                        BlocProvider.value(value: sl<FlightBookingBloc>()),
                      ],
                      child: const SetDestination(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );
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
  bool isDateMode = true;
  TimeOfDay selectedTime = TimeOfDay.now();

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
                "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
          ),
        );

        flightBookingBloc.add(
          UpdateFlightBooking(
            updateKey: FlightBookingUpdateKey.originDestination,
            updateValue: updatedOriginDestination,
          ),
        );
      }
    }
  }

  void _onTimeSelected(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });

    // Update the flight booking with the new time
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
            date: originDestination.departureDateTimeRange.date,
            time:
                "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
          ),
        );

        flightBookingBloc.add(
          UpdateFlightBooking(
            updateKey: FlightBookingUpdateKey.originDestination,
            updateValue: updatedOriginDestination,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "When is your trip?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isDateMode = true;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      isDateMode ? const Color(0xff930BFF) : Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side:
                        isDateMode
                            ? BorderSide.none
                            : const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                  ),
                ),
                child: Text(
                  "Date",
                  style: TextStyle(
                    color: isDateMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            WidgetsSpacer.horizontalSpacer8,
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isDateMode = false;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      !isDateMode ? const Color(0xff930BFF) : Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side:
                        !isDateMode
                            ? BorderSide.none
                            : const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                  ),
                ),
                child: Text(
                  "Time",
                  style: TextStyle(
                    color: !isDateMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 400,
          child:
              isDateMode
                  ? RangeDatePicker(
                    centerLeadingDate: true,
                    initialDate: selectedRange.start,
                    minDate: DateTime.now(),
                    maxDate: DateTime(2050, 10, 30),
                    enabledCellsTextStyle: const TextStyle(fontSize: 14),
                    currentDateTextStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                    singleSelectedCellTextStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    selectedCellsTextStyle: const TextStyle(fontSize: 14),
                    disabledCellsTextStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(200, 200, 200, 1),
                    ),
                    currentDateDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
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
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Select Departure Time",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.defaultColor400,
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer20,
                      SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            selectedTime.hour,
                            selectedTime.minute,
                          ),
                          onDateTimeChanged: (DateTime newDateTime) {
                            _onTimeSelected(
                              TimeOfDay(
                                hour: newDateTime.hour,
                                minute: newDateTime.minute,
                              ),
                            );
                          },
                          use24hFormat: false,
                        ),
                      ),
                    ],
                  ),
        ),
        if (isDateMode)
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
              ),
            ],
          ),
      ],
    );
  }
}
