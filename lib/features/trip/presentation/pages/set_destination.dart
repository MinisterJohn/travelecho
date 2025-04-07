import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

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
        destinationLocationCode: airport.iataCode,
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
    final TextEditingController destinationAirportSearchController =
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
                      progressIcon: Icons.flight_takeoff_outlined,
                      progressValue: originDestination.originLocationCode,
                      onPressed: () {
                        AppNavigator.push(
                            context,
                            MultiBlocProvider(providers: [
                              BlocProvider.value(
                                  value: sl<FlightBookingBloc>()),
                              BlocProvider.value(value: sl<AirportBloc>())
                            ], child: const TripScreen()));
                      });
                }
                return const SizedBox.shrink();
              }),
              WidgetsSpacer.verticalSpacer16,
              BlocProvider.value(
                value: sl<AirportBloc>(),
                child: BlocBuilder<FlightBookingBloc, FlightBookingState>(
                    builder: (context, state) {
                  String? selectedAirportCode;
                  String? selectedAirportName;

                  if (state is FlightBookingSuccess &&
                      state.flightBooking.originDestinations.isNotEmpty) {
                    final originDestination =
                        state.flightBooking.originDestinations.first;
                    selectedAirportCode =
                        originDestination.destinationLocationCode;
                    selectedAirportName =
                        originDestination.destinationLocationName;

                    // Set the text controller to the current airport name
                    if (destinationAirportSearchController.text.isEmpty &&
                        selectedAirportName.isNotEmpty) {
                      destinationAirportSearchController.text =
                          selectedAirportName;
                    }
                  }

                  return AirportSearchSection(
                    onAirportSelected: (airport) =>
                        _onDestinationAirportSelected(context, airport,
                            destinationAirportSearchController),
                    title: "Where to?",
                    hintText: "Enter your destination",
                    isDestination: true,
                    searchController: destinationAirportSearchController,
                    selectedAirportCode: selectedAirportCode,
                    selectedAirportName: selectedAirportName,
                  );
                }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: DestinationBottomBar(onClear: () {
        context.read<AirportBloc>().add(ClearAirportSearch());
      }, onNext: () {
        // context.read<AirportBloc>().add(ClearAirportSearch());
        AppNavigator.push(
            context,
            BlocProvider.value(
                value: sl<FlightBookingBloc>(), child: const FlightDate()));
      }),
    );
  }
}
