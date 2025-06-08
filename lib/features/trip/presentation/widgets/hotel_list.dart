import 'package:flutter/material.dart' hide CarouselController;
import '../../trip_exports.dart';

class HotelList extends StatelessWidget {
  final List<HotelBookingModel> hotels;

  const HotelList({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final hotel = hotels[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hotel.hotelName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        hotel.cityCode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer8,
                Text(
                  'Hotel ID: ${hotel.hotelId}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                WidgetsSpacer.verticalSpacer16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      hotel.status,
                      style: TextStyle(
                        color:
                            hotel.status == 'AVAILABLE'
                                ? Colors.green
                                : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                WidgetsSpacer.verticalSpacer16,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Show booking dialog
                      _showBookingDialog(context, hotel);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: hotels.length),
    );
  }

  void _showBookingDialog(BuildContext context, HotelBookingModel hotel) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Book ${hotel.hotelName}'),
            content: const Text(
              'Booking functionality will be implemented in the next phase.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
