import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../trip_exports.dart';

class FlightSummaryCard extends StatelessWidget {
  final Map<String, dynamic> departure;
  final Map<String, dynamic> arrival;
  final String total;
  final String carrierCode;
  final String flightNumber;

  const FlightSummaryCard({
    super.key,
    required this.departure,
    required this.arrival,
    required this.total,
    required this.carrierCode,
    required this.flightNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AirlineCubit, AirlineState>(
                      builder: (context, state) {
                        if (state is AirlineLoaded &&
                            state.airlines.isNotEmpty) {
                          return Row(
                            children: [
                              const Icon(Icons.airplanemode_active,
                                  color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                state.airlines.first['commonName'] ??
                                    "Airline Name",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            const Icon(Icons.airplanemode_active,
                                color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              carrierCode ?? "Unknown Airline",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Flight $flightNumber",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "\$${double.tryParse(total)?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flight_takeoff, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(departure['at']),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        departure['iataCode'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.airplanemode_active, color: Colors.white),
                    Container(
                      width: 100,
                      height: 1,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Text(
                      _calculateDuration(departure['at'], arrival['at']),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _formatTime(arrival['at']),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.flight_land, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        arrival['iataCode'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return 'N/A';
    try {
      return timeString.split('T')[1].substring(0, 5);
    } catch (e) {
      return 'N/A';
    }
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
