import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class FlightBookingPreview extends StatelessWidget {
  const FlightBookingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Flight Booking Preview", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<FlightBookingBloc, FlightBookingState>(
                builder: (context, state) {
                  if (state is FlightBookingSuccess) {
                    final booking = state.flightBooking;
                    final originDestination = booking.originDestinations.first;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection("Flight Details", [
                          _buildDetailRow(
                            "From",
                            originDestination.originLocationName,
                          ),
                          _buildDetailRow(
                            "To",
                            originDestination.destinationLocationName,
                          ),
                          _buildDetailRow(
                            "Date",
                            "${originDestination.departureDateTimeRange.date} ${originDestination.departureDateTimeRange.time}",
                          ),
                        ]),
                        WidgetsSpacer.verticalSpacer16,
                        _buildSection("Travelers", [
                          _buildDetailRow(
                            "Adults",
                            "${booking.travelers.where((t) => t.travelerType == "ADULT").length}",
                          ),
                          _buildDetailRow(
                            "Children",
                            "${booking.travelers.where((t) => t.travelerType == "CHILD").length}",
                          ),
                          _buildDetailRow(
                            "Infants",
                            "${booking.travelers.where((t) => t.travelerType == "INFANT").length}",
                          ),
                        ]),
                        WidgetsSpacer.verticalSpacer32,
                        ElevatedButton(
                          onPressed: () {
                            AppNavigator.push(
                              context,
                              MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: sl<FlightBookingBloc>(),
                                  ),
                                  BlocProvider.value(
                                    value: sl<FlightOffersBloc>(),
                                  ),
                                  BlocProvider(
                                    create: (context) => sl<AirlineCubit>(),
                                  ),
                                ],
                                child: const FlightOffers(),
                              ),
                            );
                          },
                          style: mergeWithThemeButtonStyle(
                            context,
                            ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: FontSize.size16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer8,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.defaultColor100),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
