import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../trip_exports.dart';

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
  void initState() {
    super.initState();
    _loadSavedTravelers();
  }

  void _loadSavedTravelers() {
    final state = context.read<FlightBookingBloc>().state;
    if (state is FlightBookingSuccess) {
      setState(() {
        // Count travelers by type
        for (var traveler in state.flightBooking.travelers) {
          switch (traveler.travelerType.toUpperCase()) {
            case 'ADULT':
              adults++;
              break;
            case 'CHILD':
              children++;
              break;
            case 'INFANT':
              infants++;
              break;
          }
        }
      });
    }
  }

  void _updateTravelers() {
    final flightBookingBloc = context.read<FlightBookingBloc>();

    // Clear existing travelers
    flightBookingBloc.clearTravelers();

    // Add adults
    for (int i = 0; i < adults; i++) {
      flightBookingBloc.addTraveler(
        id: "ADT_$i",
        travelerType: "ADULT",
      );
    }

    // Add children
    for (int i = 0; i < children; i++) {
      flightBookingBloc.addTraveler(
        id: "CHD_$i",
        travelerType: "CHILD",
      );
    }

    // Add infants
    for (int i = 0; i < infants; i++) {
      flightBookingBloc.addTraveler(
        id: "INF_$i",
        travelerType: "INFANT",
      );
    }
  }

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
              _progressDisplay(),
              WidgetsSpacer.verticalSpacer16,
              _peopleComing(),
              WidgetsSpacer.verticalSpacer16,
              if (adults > 0 || children > 0 || infants > 0 || pets > 0)
                ElevatedButton(
                  onPressed: () {
                    AppNavigator.push(
                      context,
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: sl<FlightBookingBloc>()),
                        ],
                        child: const TravelerDetailsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressDisplay() {
    return BlocBuilder<FlightBookingBloc, FlightBookingState>(
      builder: (context, state) {
        if (state is FlightBookingSuccess) {
          final originDestination =
              state.flightBooking.originDestinations.first;
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
                WidgetsSpacer.horizontalSpacer8,
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
                WidgetsSpacer.horizontalSpacer8,
                TripProgressDisplay(
                    progressIcon: Icons.calendar_month_outlined,
                    progressKey: "Date",
                    progressValue:
                        originDestination.departureDateTimeRange.date,
                    onPressed: () {
                      AppNavigator.push(
                          context,
                          BlocProvider.value(
                              value: sl<FlightBookingBloc>(),
                              child: const FlightDate()));
                    }),
                WidgetsSpacer.horizontalSpacer8,
                TripProgressDisplay(
                    progressIcon: Icons.access_time_outlined,
                    progressKey: "Departure Time",
                    progressValue:
                        originDestination.departureDateTimeRange.time,
                    onPressed: () {
                      AppNavigator.push(
                          context,
                          BlocProvider.value(
                              value: sl<FlightBookingBloc>(),
                              child: const FlightDate()));
                    }),
              ]));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _setofpeople(String category, String categoryDescription, int value,
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
                  categoryDescription,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 0, 0, .5)),
                ),
              ],
            ),
            Row(
              children: [
                if (value > 0)
                  IconButton(
                    onPressed: () {
                      onDecrement();
                      _updateTravelers();
                    },
                    icon: const Icon(LineIcons.minusSquare,
                        color: AppColors.defaultColor400),
                  ),
                const SizedBox(width: 4),
                Text(
                  "$value",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    onIncrement();
                    _updateTravelers();
                  },
                  icon: const Icon(LineIcons.plusSquare,
                      color: AppColors.defaultColor400),
                ),
              ],
            )
          ],
        ),
        WidgetsSpacer.verticalSpacer8,
        const Divider(height: 2, color: AppColors.defaultColor100),
        WidgetsSpacer.verticalSpacer8,
      ],
    );
  }

  Widget _peopleComing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Who's coming?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer16,
        Column(
          children: [
            _setofpeople(
              "Adults",
              "Age 12 and above",
              adults,
              () {
                setState(() {
                  adults += 1;
                });
              },
              () {
                setState(() {
                  if (adults > 0) adults -= 1;
                });
              },
            ),
            _setofpeople(
              "Children",
              "Age 2-11",
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
