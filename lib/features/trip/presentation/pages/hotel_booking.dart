import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class HotelBooking extends StatelessWidget {
  const HotelBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Hotel Booking", context),
      body: BlocBuilder<HotelBookingBloc, HotelBookingState>(
        builder: (context, state) {
          if (state is HotelBookingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HotelBookingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HotelBookingBloc>().add(
                            const SearchHotels(
                              query: 'Paris',
                            ),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Theme.of(context).primaryColor,
                  //   borderRadius: const BorderRadius.only(
                  //     bottomLeft: Radius.circular(30),
                  //     bottomRight: Radius.circular(30),
                  //   ),
                  // ),
                  padding: const EdgeInsets.all(16),
                  child: const HotelSearchForm(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: state is HotelBookingSuccess && state.hotels.isNotEmpty
                    ? HotelList(hotels: state.hotels)
                    : const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              'Search for hotels to see available options',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
