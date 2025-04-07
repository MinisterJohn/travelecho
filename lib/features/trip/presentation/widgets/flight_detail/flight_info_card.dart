import 'package:flutter/material.dart';
import '../../../trip_exports.dart';

class FlightInfoCard extends StatelessWidget {
  final Map<String, dynamic> firstSegment;
  final dynamic flightOffer;
  final String cabinClass;
  final String fareBasis;
  final String brandedFareLabel;
  final String checkedBags;
  final String cabinBags;
  final String amenityDescriptions;

  const FlightInfoCard({
    Key? key,
    required this.firstSegment,
    required this.flightOffer,
    required this.cabinClass,
    required this.fareBasis,
    required this.brandedFareLabel,
    required this.checkedBags,
    required this.cabinBags,
    required this.amenityDescriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      'Flight Information',
      Icons.info_outline,
      [
        _buildInfoRow(
          'Aircraft',
          firstSegment['aircraft']?['code'] ?? 'N/A',
          Icons.airplanemode_active,
        ),
        _buildInfoRow(
          'Seats Available',
          (flightOffer['numberOfBookableSeats'] ?? 0).toString(),
          Icons.chair,
        ),
        _buildInfoRow(
          'Booking End Date',
          flightOffer['lastTicketingDate'] ?? 'N/A',
          Icons.calendar_today,
        ),
        _buildInfoRow(
          'Flight Duration',
          _calculateDuration(
            firstSegment['departure']?['at'],
            firstSegment['arrival']?['at'],
          ),
          Icons.timer,
        ),
        _buildInfoRow(
          'Cabin Class',
          cabinClass,
          Icons.airline_seat_recline_normal,
        ),
        _buildInfoRow(
          'Fare Basis',
          fareBasis,
          Icons.receipt_long,
        ),
        _buildInfoRow(
          'Branded Fare',
          brandedFareLabel,
          Icons.sell,
        ),
        _buildInfoRow(
          'Checked Baggage',
          '$checkedBags piece(s)',
          Icons.luggage,
        ),
        _buildInfoRow(
          'Cabin Baggage',
          '$cabinBags piece(s)',
          Icons.backpack,
        ),
        if (amenityDescriptions.isNotEmpty)
          _buildInfoRow(
            'Amenities',
            amenityDescriptions,
            Icons.room_service,
          ),
      ],
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),]),
          // const Spacer(),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDuration(String? departureTime, String? arrivalTime) {
    if (departureTime == null || arrivalTime == null) return 'N/A';
    try {
      final departure = DateTime.parse(departureTime);
      final arrival = DateTime.parse(arrivalTime);
      final duration = arrival.difference(departure);

      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      return '$hours h $minutes m';
    } catch (e) {
      return 'N/A';
    }
  }
}
