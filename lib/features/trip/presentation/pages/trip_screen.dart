import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  void _onOriginAirportSelected(BuildContext context, Airport airport,
      TextEditingController searchController) {
    searchController.text = airport.name;
    context.read<FlightBookingBloc>().addOriginDestination(
          id: "1",
          originLocationCode: airport.iataCode,
          originLocationName: airport.name,
          destinationLocationCode: "",
          destinationLocationName: "",
          date: DateTime.now().toIso8601String().split('T')[0],
          time: DateTime.now().toIso8601String().split('T')[1].substring(0, 5),
        );

    context.read<AirportBloc>().add(ClearAirportSearch());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController originAirportSearchController =
        TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AirportBloc>()),
        BlocProvider.value(value: sl<FlightBookingBloc>()),
      ],
      child: Scaffold(
        appBar: setAppBar("Trip", context),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const TravelPlanSection(),
              WidgetsSpacer.verticalSpacer16,
                BlocBuilder<FlightBookingBloc, FlightBookingState>(
                    builder: (context, state) {
                  String? selectedAirportCode;
                  String? selectedAirportName;

                  if (state is FlightBookingSuccess &&
                      state.flightBooking.originDestinations.isNotEmpty) {
                    final originDestination =
                        state.flightBooking.originDestinations.first;
                    selectedAirportCode = originDestination.originLocationCode;
                    selectedAirportName = originDestination.originLocationName;

                    // Set the text controller to the current airport name
                    if (originAirportSearchController.text.isEmpty) {
                      originAirportSearchController.text = selectedAirportName;
                    }
                  }

                  return AirportSearchSection(
                    onAirportSelected: (airport) => _onOriginAirportSelected(
                        context, airport, originAirportSearchController),
                    title: "Origin Airport",
                  hintText: "Enter your location",
                    isDestination: false,
                    searchController: originAirportSearchController,
                    selectedAirportCode: selectedAirportCode,
                    selectedAirportName: selectedAirportName,
                  );
                }),
                WidgetsSpacer.verticalSpacer16,
                BlocBuilder<FlightBookingBloc, FlightBookingState>(
                  builder: (context, state) {
                    if (state is FlightBookingSuccess &&
                        state.flightBooking.originDestinations.isNotEmpty) {
                      return OutlinedButton(
                onPressed: () {
                          AppNavigator.push(
                            context,
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: sl<FlightBookingBloc>(),
                                ),
                                BlocProvider.value(
                                  value: sl<AirportBloc>(),
                                ),
                              ],
                              child: const SetDestination(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Select Destination",
                          style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
