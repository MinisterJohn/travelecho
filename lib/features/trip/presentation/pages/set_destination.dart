import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';
import '../widgets/trip_progress_display.dart';
import '../widgets/destination_bottom_bar.dart';
import '../widgets/airport_search_section.dart';

class SetDestination extends StatelessWidget {
  const SetDestination({super.key});

  void _onDestinationAirportSelected(BuildContext context, Airport airport,
      TextEditingController searchController) {
    // Update flight booking with destination airport
    final flightBookingBloc = context.read<FlightBookingBloc>();
    final currentBooking = flightBookingBloc.flightBooking;

    searchController.text = airport.name;

    if (currentBooking.originDestinations.isNotEmpty) {
      final originDestination = currentBooking.originDestinations.first;
      final updatedOriginDestination = OriginDestination(
        id: originDestination.id,
        originLocationCode: originDestination.originLocationCode,
        originLocationName: originDestination.originLocationName,
        destinationLocationCode: airport.iata,
        destinationLocationName: airport.name,
        departureDateTimeRange: originDestination.departureDateTimeRange,
      );

      flightBookingBloc.add(UpdateFlightBooking(
        updateKey: FlightBookingUpdateKey.originDestination,
        updateValue: updatedOriginDestination,
      ));
    }

    context.read<AirportBloc>().add(ClearAirportSearch());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _destinationAirportSearchController =
        TextEditingController();

    return Scaffold(
      appBar: setAppBar("Trip Destination", context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<FlightBookingBloc, FlightBookingState>(
                  builder: (context, state) {
                if (state is FlightBookingSuccess) {
                  final originDestination =
                      state.flightBooking.originDestinations.first;
                  return TripProgressDisplay(
                      progressKey: "Origin Airport",
                      progressValue: originDestination.originLocationName,
                      onPressed: () {
                        AppNavigator.push(
                            context,
                            BlocProvider.value(
                                value: sl<FlightBookingBloc>(),
                                child: const TripScreen()));
                      });
                }
                return const SizedBox.shrink();
              }),
              WidgetsSpacer.verticalSpacer16,
              BlocProvider.value(
                value: sl<AirportBloc>(),
                child: AirportSearchSection(
                  onAirportSelected: (airport) => _onDestinationAirportSelected(
                      context, airport, _destinationAirportSearchController),
                  title: "Where to?",
                  hintText: "Enter your destination",
                  isDestination: true,
                  searchController: _destinationAirportSearchController,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: DestinationBottomBar(onClear: () {
        context.read<AirportBloc>().add(ClearAirportSearch());
      }, onNext: () {
        AppNavigator.push(
            context,
            BlocProvider.value(
                value: sl<FlightBookingBloc>(), child: const FlightDate()));
      }),
    );
  }
}
