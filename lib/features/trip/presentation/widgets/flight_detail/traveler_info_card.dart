import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../trip_exports.dart';

class TravelerInfoCard extends StatelessWidget {
  final List<Map> travelers;

  const TravelerInfoCard({super.key, required this.travelers});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightBookingBloc, FlightBookingState>(
      builder: (context, state) {
        if (state is FlightBookingSuccess) {
          final travelerDetailsMap =
              context.read<FlightBookingBloc>().travelerDetailsMap;

          return _buildSectionCard('Traveler Information', Icons.people, [
            for (var traveler in travelers)
              _buildTravelerRow(
                traveler['id'] as String,
                traveler['travelerType'] ?? 'Unknown',
                traveler['fareOption'] ?? 'Unknown',
                traveler['price'] ?? {},
                travelerDetailsMap[traveler['id'] as String],
              ),
          ]);
        }

        // Fallback if state is not FlightBookingSuccess
        return _buildSectionCard('Traveler Information', Icons.people, [
          for (var traveler in travelers)
            _buildTravelerRow(
              traveler['id'] as String,
              traveler['travelerType'] ?? 'Unknown',
              traveler['fareOption'] ?? 'Unknown',
              traveler['price'] ?? {},
              null,
            ),
        ]);
      },
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor),
                WidgetsSpacer.horizontalSpacer8,
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTravelerRow(
    String travelerId,
    String travelerType,
    String fareOption,
    Map price,
    TravelerDetails? travelerDetails,
  ) {
    final String displayName =
        travelerDetails != null
            ? '${travelerDetails.name.firstName} ${travelerDetails.name.lastName}'
            : 'Not specified';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.person, size: 18, color: Colors.grey),
          WidgetsSpacer.horizontalSpacer8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Traveler: $travelerType',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Name: $displayName',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fare option: $fareOption',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Price: \$${price['total']}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
