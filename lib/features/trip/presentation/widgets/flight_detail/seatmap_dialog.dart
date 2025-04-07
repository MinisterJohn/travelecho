import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/seatmap/seatmap_cubit.dart';

class SeatmapDialog extends StatelessWidget {
  final dynamic flightOffer;

  const SeatmapDialog({
    Key? key,
    required this.flightOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.read<SeatmapCubit>()..getSeatmap(flightOffer),
      child: BlocBuilder<SeatmapCubit, SeatmapState>(
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Seat Map',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(),

                  // Content
                  Expanded(
                    child: state is SeatmapLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state is SeatmapLoaded
                            ? _buildSeatmap(state.seatmapData)
                            : state is SeatmapError
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          size: 48,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          state.message,
                                          style: const TextStyle(
                                              color: Colors.red),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                  ),

                  // Legend
                  if (state is SeatmapLoaded) _buildLegend(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeatmap(Map<String, dynamic> seatmapData) {
    // Extract seatmap data from the API response
    final data = seatmapData['data'] as List?;
    if (data == null || data.isEmpty) {
      return const Center(
        child: Text('No seatmap data available'),
      );
    }

    // Get the first seatmap
    final seatmap = data.first;

    // Extract flight information
    final departure = seatmap['departure'] as Map<String, dynamic>?;
    final arrival = seatmap['arrival'] as Map<String, dynamic>?;
    final aircraft = seatmap['aircraft'] as Map<String, dynamic>?;
    final aircraftCode = aircraft?['code'] ?? 'Unknown';

    // Extract cabin amenities
    final amenities =
        seatmap['aircraftCabinAmenities'] as Map<String, dynamic>?;
    final seatInfo = amenities?['seat'] as Map<String, dynamic>?;
    final legSpace = seatInfo?['legSpace']?.toString() ?? 'Unknown';
    final spaceUnit = seatInfo?['spaceUnit'] ?? 'INCHES';

    // Extract deck information
    final decks = seatmap['decks'] as List?;
    if (decks == null || decks.isEmpty) {
      return const Center(
        child: Text('No deck information available'),
      );
    }

    // Get the first deck
    final deck = decks.first;
    final deckConfig = deck['deckConfiguration'] as Map<String, dynamic>?;
    final exitRows = deckConfig?['exitRowsX'] as List? ?? [];
    final seats = deck['seats'] as List?;

    if (seats == null || seats.isEmpty) {
      return const Center(
        child: Text('No seat information available'),
      );
    }

    // Group seats by row
    final Map<String, List<Map<String, dynamic>>> seatsByRow = {};
    for (final seat in seats) {
      final seatNumber = seat['number'] as String? ?? '';
      final rowNumber = seatNumber.replaceAll(RegExp(r'[A-Z]'), '');

      if (!seatsByRow.containsKey(rowNumber)) {
        seatsByRow[rowNumber] = [];
      }

      seatsByRow[rowNumber]!.add(seat);
    }

    // Sort rows numerically
    final sortedRows = seatsByRow.keys.toList()
      ..sort((a, b) => int.tryParse(a)?.compareTo(int.tryParse(b) ?? 0) ?? 0);

    // Build a seatmap visualization
    return Column(
      children: [
        // Flight information
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                '${departure?['iataCode'] ?? 'Unknown'} → ${arrival?['iataCode'] ?? 'Unknown'}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Aircraft: Boeing ${aircraftCode}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              if (legSpace != 'Unknown')
                Text(
                  'Leg Space: $legSpace $spaceUnit',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Seat rows
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Aisle indicator
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'AISLE',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),

                // Seat rows with horizontal scrolling
                ...sortedRows.map((rowNumber) {
                  final rowSeats = seatsByRow[rowNumber]!;

                  // Sort seats by letter (A, B, C, J, K, L)
                  rowSeats.sort((a, b) {
                    final aLetter = (a['number'] as String)
                        .replaceAll(RegExp(r'[0-9]'), '');
                    final bLetter = (b['number'] as String)
                        .replaceAll(RegExp(r'[0-9]'), '');
                    return aLetter.compareTo(bLetter);
                  });

                  // Check if this is an exit row
                  final isExitRow = exitRows.contains(int.tryParse(rowNumber));

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        // Row number with exit row indicator
                        Row(
                          children: [
                            // Row number (fixed)
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    rowNumber,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (isExitRow)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Icon(
                                        Icons.exit_to_app,
                                        size: 16,
                                        color: Colors.orange.shade700,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Seats (horizontally scrollable)
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: rowSeats.map((seat) {
                                    final seatNumber =
                                        seat['number'] as String? ?? '';
                                    final seatLetter = seatNumber.replaceAll(
                                        RegExp(r'[0-9]'), '');
                                    final availabilityStatus =
                                        seat['travelerPricing']?[0]
                                                    ?['seatAvailabilityStatus']
                                                as String? ??
                                            'UNKNOWN';
                                    final characteristics =
                                        seat['characteristicsCodes'] as List? ??
                                            [];

                                    // Determine seat color based on availability and characteristics
                                    Color seatColor = Colors.grey;
                                    if (availabilityStatus == 'AVAILABLE') {
                                      seatColor = Colors.green;
                                    } else if (availabilityStatus ==
                                        'OCCUPIED') {
                                      seatColor = Colors.red;
                                    } else if (availabilityStatus ==
                                        'BLOCKED') {
                                      seatColor = Colors.orange;
                                    }

                                    // Add special indicators for seat characteristics
                                    bool isWindow =
                                        characteristics.contains('W');
                                    bool isAisle =
                                        characteristics.contains('A');
                                    bool isExit = characteristics.contains('E');
                                    bool isLegSpace =
                                        characteristics.contains('L');
                                    bool isChargeable =
                                        characteristics.contains('CH');

                                    // Add a border for special seats
                                    BoxBorder? specialBorder;
                                    if (isWindow ||
                                        isAisle ||
                                        isExit ||
                                        isLegSpace ||
                                        isChargeable) {
                                      specialBorder = Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      );
                                    }

                                    return Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        color: seatColor,
                                        borderRadius: BorderRadius.circular(4),
                                        border: specialBorder,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          seatLetter,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isExitRow)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Exit Row',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legend',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem('Available', Colors.green),
              _buildLegendItem('Occupied', Colors.red),
              _buildLegendItem('Blocked', Colors.orange),
              _buildLegendItem('Window', Colors.grey, isSpecial: true),
              _buildLegendItem('Aisle', Colors.grey, isSpecial: true),
              _buildLegendItem('Exit Row', Colors.grey,
                  isSpecial: true, isExit: true),
              _buildLegendItem('Leg Space', Colors.grey, isSpecial: true),
              _buildLegendItem('Chargeable', Colors.grey, isSpecial: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color,
      {bool isSpecial = false, bool isExit = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border:
                isSpecial ? Border.all(color: Colors.black, width: 1.5) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: isExit
              ? Center(
                  child: Icon(
                    Icons.exit_to_app,
                    size: 12,
                    color: Colors.orange.shade700,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
