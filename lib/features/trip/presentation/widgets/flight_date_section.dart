import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class FlightDateSection extends StatelessWidget {
  const FlightDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightBookingBloc, FlightBookingState>(
      builder: (context, state) {
        if (state is FlightBookingSuccess) {
          final originDestination =
              state.flightBooking.originDestinations.first;
          return ElevatedButton(
            onPressed: () {
              AppNavigator.push(
                context,
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: sl<FlightBookingBloc>()),
                    BlocProvider.value(value: sl<AirportBloc>()),
                  ],
                  child: const FlightDate(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 70),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Flight Date",
                  style: TextStyle(color: Colors.black),
                ),
                WidgetsSpacer.horizontalSpacer8,
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                    ),
                    Text(
                      "${originDestination.departureDateTimeRange.date} ${originDestination.departureDateTimeRange.time}",
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
