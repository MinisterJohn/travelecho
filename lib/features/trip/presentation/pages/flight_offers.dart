import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class FlightOffers extends StatefulWidget {
  const FlightOffers({super.key});

  @override
  State<FlightOffers> createState() => _FlightOffersState();
}

class _FlightOffersState extends State<FlightOffers> {
  // Map to track which offers have details shown
  final Map<String, bool> _showDetailsMap = {};

  @override
  void initState() {
    super.initState();
    _searchFlights();
  }

  void _searchFlights() {
    final flightBookingBloc = context.read<FlightBookingBloc>();
    final flightOffersBloc = context.read<FlightOffersBloc>();

    if (flightBookingBloc.state is FlightBookingSuccess) {
      final booking =
          (flightBookingBloc.state as FlightBookingSuccess).flightBooking;
      final originDestination = booking.originDestinations.first;

      // Count travelers by type
      final adults =
          booking.travelers.where((t) => t.travelerType == "ADULT").length;
      final children =
          booking.travelers.where((t) => t.travelerType == "CHILD").length;
      final infants =
          booking.travelers.where((t) => t.travelerType == "INFANT").length;

      flightOffersBloc.add(
        SearchFlightOffers(
          origin: originDestination.originLocationCode,
          destination: originDestination.destinationLocationCode,
          departureDate: originDestination.departureDateTimeRange.date,
          adults: adults,
          children: children,
          infants: infants,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Available Flights", context),
      body: BlocBuilder<FlightBookingBloc, FlightBookingState>(
        builder: (context, state) {
          if (state is FlightBookingSuccess) {
            final booking = state.flightBooking;
            final originDestination = booking.originDestinations.first;

            return Column(
              children: [
                // Flight search criteria summary
                Container(
                  padding: const EdgeInsets.all(16),
                  // color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _progressDisplay(),
                      WidgetsSpacer.verticalSpacer8,
                      Row(
                        children: [
                          const Icon(Icons.person_outline_outlined),
                          WidgetsSpacer.horizontalSpacer8,
                          Text(
                            "${booking.travelers.length} ${booking.travelers.length == 1 ? "Traveler" : "Travelers"}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Flight offers list
                Expanded(
                  child: BlocBuilder<FlightOffersBloc, FlightOffersState>(
                    builder: (context, state) {
                      if (state is FlightOffersLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FlightOffersLoaded) {
                        final offers = state.flightOffers;
                        if (offers.isEmpty) {
                          return const Center(child: Text('No flights found'));
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            final flightBookingBloc =
                                context.read<FlightBookingBloc>();
                            if (flightBookingBloc.state
                                is FlightBookingSuccess) {
                              final booking =
                                  (flightBookingBloc.state
                                          as FlightBookingSuccess)
                                      .flightBooking;
                              final originDestination =
                                  booking.originDestinations.first;

                              // Count travelers by type
                              final adults =
                                  booking.travelers
                                      .where((t) => t.travelerType == "ADULT")
                                      .length;
                              final children =
                                  booking.travelers
                                      .where((t) => t.travelerType == "CHILD")
                                      .length;
                              final infants =
                                  booking.travelers
                                      .where((t) => t.travelerType == "INFANT")
                                      .length;

                              context.read<FlightOffersBloc>().add(
                                SearchFlightOffers(
                                  origin: originDestination.originLocationCode,
                                  destination:
                                      originDestination.destinationLocationCode,
                                  departureDate:
                                      originDestination
                                          .departureDateTimeRange
                                          .date,
                                  adults: adults,
                                  children: children,
                                  infants: infants,
                                ),
                              );
                            }
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: offers.length,
                            itemBuilder: (context, index) {
                              final offer = offers[index];
                              return _buildFlightOfferCard(offer);
                            },
                          ),
                        );
                      } else if (state is FlightOffersError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildFlightOfferCard(dynamic offer) {
    final itineraries = offer['itineraries'] as List;
    final firstItinerary = itineraries.first;
    final segments = firstItinerary['segments'] as List;
    final firstSegment = segments.first;
    final departure = firstSegment['departure'];
    final arrival = firstSegment['arrival'];
    final price = offer['price'] as Map;
    final total = price['total'] as String;
    final offerId = offer['id'] as String;

    // Initialize if not present
    _showDetailsMap[offerId] ??= false;

    // context
    //     .read<FlightOffersBloc>()
    //     .add(SearchAirline(airlineCode: firstSegment['carrierCode']));
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${firstSegment['carrierCode'] + "${firstSegment['aircraft']['code']}" ?? "Airline Name"}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.flight_takeoff, size: 16),
                        WidgetsSpacer.horizontalSpacer8,
                        Text(departure['at'].split('T')[1].substring(0, 5)),
                        WidgetsSpacer.horizontalSpacer16,
                        const Icon(Icons.flight_land, size: 16),
                        WidgetsSpacer.horizontalSpacer8,
                        Text(arrival['at'].split('T')[1].substring(0, 5)),
                      ],
                    ),
                    WidgetsSpacer.verticalSpacer8,
                    Text("Seats Available: ${offer['numberOfBookableSeats']}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${double.parse(total).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Text(
                      "per person",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    WidgetsSpacer.verticalSpacer8,
                    TextButton(
                      onPressed: () {
                        AppNavigator.push(
                          context,
                          MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: sl<AirlineCubit>()),
                              BlocProvider.value(
                                value: sl<FlightPricingCubit>(),
                              ),
                              BlocProvider.value(value: sl<FlightOffersBloc>()),
                              BlocProvider.value(
                                value: sl<FlightBookingBloc>(),
                              ),
                              BlocProvider.value(value: sl<SeatmapCubit>()),
                            ],
                            child: FlightDetail(flightOffer: offer),
                          ),
                        );
                      },
                      child: const Text("View Details"),
                    ),
                  ],
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer8,
            WidgetsSpacer.verticalSpacer16,
            ElevatedButton(
              onPressed: () {
                // Navigate to booking confirmation
                AppNavigator.push(context, const TripNotification());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Select Flight",
                style: TextStyle(
                  fontSize: FontSize.size16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _FlightDetails(dynamic offer, dynamic firstSegment) {
    // Trigger the airline search using the new cubit
    context.read<AirlineCubit>().searchAirline(firstSegment['carrierCode']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.defaultColor100, thickness: 2),
        const Text("Flight Details"),
        WidgetsSpacer.verticalSpacer8,
        Text("Ticket Booking end date: ${offer['lastTicketingDate']}"),
        WidgetsSpacer.verticalSpacer8,
        BlocBuilder<AirlineCubit, AirlineState>(
          builder: (context, state) {
            if (state is AirlineLoaded && state.airlines.isNotEmpty) {
              return Text(
                "Airline: ${state.airlines.first['commonName'] ?? "Airline Name"} (${firstSegment['carrierCode'] + "${firstSegment['aircraft']['code']}" ?? "Airline Name"})",
              );
            }
            return Text("Airline: ${firstSegment['carrierCode']}");
          },
        ),
      ],
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
                          BlocProvider.value(value: sl<FlightOffersBloc>()),
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
                WidgetsSpacer.horizontalSpacer8,
                TripProgressDisplay(
                  progressIcon: Icons.calendar_month_outlined,
                  progressKey: "Date",
                  progressValue: originDestination.departureDateTimeRange.date,
                  onPressed: () {
                    AppNavigator.push(
                      context,
                      BlocProvider.value(
                        value: sl<FlightBookingBloc>(),
                        child: const FlightDate(),
                      ),
                    );
                  },
                ),
                WidgetsSpacer.horizontalSpacer8,
                TripProgressDisplay(
                  progressIcon: Icons.access_time_outlined,
                  progressKey: "Departure Time",
                  progressValue: originDestination.departureDateTimeRange.time,
                  onPressed: () {
                    AppNavigator.push(
                      context,
                      BlocProvider.value(
                        value: sl<FlightBookingBloc>(),
                        child: const FlightDate(),
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
}
