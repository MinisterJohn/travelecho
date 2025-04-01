import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';
import '../widgets/travel_plan_section.dart';
import '../widgets/airport_search_section.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  void _onOriginAirportSelected(BuildContext context, Airport airport,
      TextEditingController searchController) {
    searchController.text = airport.name;
    context.read<FlightBookingBloc>().addOriginDestination(
          id: "1",
          originLocationCode: airport.iata,
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
    final TextEditingController _originAirportSearchController =
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
                AirportSearchSection(
                  onAirportSelected: (airport) => _onOriginAirportSelected(
                      context, airport, _originAirportSearchController),
                  title: "Origin Airport",
                  hintText: "Enter your location",
                  isDestination: false,
                  searchController: _originAirportSearchController,
                ),
                WidgetsSpacer.verticalSpacer16,
                BlocBuilder<FlightBookingBloc, FlightBookingState>(
                  builder: (context, state) {
                    if (state is FlightBookingSuccess &&
                        state.flightBooking.originDestinations.isNotEmpty) {
                      return OutlinedButton(
                        onPressed: () {
                          AppNavigator.push(
                            context,
                            BlocProvider.value(
                              value: sl<FlightBookingBloc>(),
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
