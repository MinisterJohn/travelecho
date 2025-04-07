import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class FlightDetail extends StatefulWidget {
  final dynamic flightOffer;

  const FlightDetail({
    Key? key,
    required this.flightOffer,
  }) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  @override
  void initState() {
    super.initState();
    _loadPricingInfo();
    _loadAirlineInfo();
  }

  void _loadPricingInfo() {
    context
        .read<FlightPricingCubit>()
        .getFlightOfferPricing(widget.flightOffer);
  }

  void _loadAirlineInfo() {
    try {
      final itineraries = widget.flightOffer['itineraries'] as List? ?? [];
      if (itineraries.isEmpty) return;

      final firstItinerary = itineraries.first;
      final segments = firstItinerary['segments'] as List? ?? [];
      if (segments.isEmpty) return;

      final firstSegment = segments.first;
      final carrierCode = firstSegment['carrierCode'] as String?;

      if (carrierCode != null) {
        context.read<AirlineCubit>().searchAirline(carrierCode);
      }
    } catch (error) {
      debugPrint('Error loading airline info: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Flight Details", context),
      body: BlocConsumer<FlightPricingCubit, FlightPricingState>(
        listener: (context, state) {
          if (state is FlightPricingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FlightPricingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final flightOfferPricing = state is FlightPricingLoaded
              ? state.pricingData
              : widget.flightOffer;

          try {
            final itineraries = flightOfferPricing['itineraries'] as List;
            final outboundSegments = itineraries[0]['segments'] as List;
            final returnSegments = itineraries.length > 1
                ? itineraries[1]['segments'] as List
                : [];
            final firstSegment = outboundSegments.first;

            // Extract pricing information
            final price = flightOfferPricing['price'] ?? {};
            final total = price['total'] as String? ?? '0';

            // Extract traveler pricing information
            final travelerPricings =
                flightOfferPricing['travelerPricings'] ?? [];
            final firstTraveler =
                travelerPricings.isNotEmpty ? travelerPricings.first : null;
            final travelerPrice = firstTraveler?['price'] ?? {};

            // Combine all taxes
            final taxes = [];
            if (travelerPrice['taxes'] != null) {
              final travelerTaxes = travelerPrice['taxes'];
              for (var tax in travelerTaxes) {
                taxes.add(tax);
              }
            } else if (price['taxes'] != null) {
              final priceTaxes = price['taxes'];
              for (var tax in priceTaxes) {
                taxes.add(tax);
              }
            }

            // Calculate total taxes
            double totalTaxes = 0;
            for (var tax in taxes) {
              totalTaxes += double.tryParse(tax['amount'] ?? '0') ?? 0;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Outbound Flight
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Outbound Flight",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...outboundSegments
                      .map((segment) => FlightSummaryCard(
                            departure: segment['departure'],
                            arrival: segment['arrival'],
                            total: flightOfferPricing['price']['total'],
                            carrierCode: segment['carrierCode'],
                            flightNumber: segment['number'],
                          ))
                      .toList(),

                  // Return Flight (if exists)
                  if (returnSegments.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Return Flight",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...returnSegments
                        .map((segment) => FlightSummaryCard(
                              departure: segment['departure'],
                              arrival: segment['arrival'],
                              total: flightOfferPricing['price']['total'],
                              carrierCode: segment['carrierCode'],
                              flightNumber: segment['number'],
                            ))
                        .toList(),
                  ],

                  FlightInfoCard(
                    firstSegment: firstSegment,
                    flightOffer: widget.flightOffer,
                    cabinClass: flightOfferPricing['travelerPricings']?[0]
                            ?['fareDetailsBySegment']?[0]?['cabin'] ??
                        'N/A',
                    fareBasis: flightOfferPricing['travelerPricings']?[0]
                            ?['fareDetailsBySegment']?[0]?['fareBasis'] ??
                        'N/A',
                    brandedFareLabel: flightOfferPricing['travelerPricings']?[0]
                                ?['fareDetailsBySegment']?[0]
                            ?['brandedFareLabel'] ??
                        'N/A',
                    checkedBags: flightOfferPricing['travelerPricings']?[0]
                                    ?['fareDetailsBySegment']?[0]
                                ?['includedCheckedBags']?['quantity']
                            ?.toString() ??
                        '0',
                    cabinBags: flightOfferPricing['travelerPricings']?[0]
                                    ?['fareDetailsBySegment']?[0]
                                ?['includedCabinBags']?['quantity']
                            ?.toString() ??
                        '0',
                    amenityDescriptions: flightOfferPricing['travelerPricings']
                                ?[0]?['fareDetailsBySegment']?[0]?['amenities']
                            ?.map((a) => a['description'] ?? '')
                            .join(',') ??
                        '',
                  ),
                  if (travelerPricings.isNotEmpty)
                    TravelerInfoCard(
                      travelers: (travelerPricings as List)
                          .map((tp) => {
                                'id': tp['travelerId'] as String,
                                'type': tp['travelerType'] as String,
                                'fareOption': tp['fareOption'] as String,
                                'price': tp['price'] as Map<String, dynamic>,
                              })
                          .toList(),
                    ),
                  PriceBreakdownCard(
                    baseFare: price['base'] as String? ?? '0',
                    totalTaxes: totalTaxes.toString(),
                    // fees: price['fees'] ?? [],
                    total: total,
                  ),
                  Text(
                    "Seats Available: ${widget.flightOffer['numberOfBookableSeats']}",
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: sl<SeatmapCubit>(),
                          child: SeatmapDialog(
                            flightOffer: widget.flightOffer,
                          ),
                        ),
                      );
                    },
                    icon:
                        const Icon(Icons.airline_seat_recline_normal, size: 16),
                    label: const Text("View Seat Map"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement booking functionality
                      },
                      icon: const Icon(Icons.flight_takeoff),
                      label: const Text('Book This Flight'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } catch (error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading flight details: ${error.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
