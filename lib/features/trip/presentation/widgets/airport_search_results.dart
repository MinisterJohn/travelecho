import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../trip_exports.dart';

class AirportSearchResults extends StatelessWidget {
  final Function(Airport) onAirportSelected;
  final String title;
  final bool isDestination;
  final double maxHeight;
  final bool showDivider;

  const AirportSearchResults({
    super.key,
    required this.onAirportSelected,
    this.title = "Search Results",
    this.isDestination = false,
    this.maxHeight = 300,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirportBloc, AirportState>(
      builder: (context, state) {
        if (state is AirportLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AirportLoaded) {
          if (state.citiesAndAirports.isEmpty) {
            return const Center(child: Text("No airports found"));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, .6),
                ),
              ),
              WidgetsSpacer.verticalSpacer16,
              SizedBox(
                height: maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: state.citiesAndAirports.map((airport) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => onAirportSelected(airport),
                            child: Row(
                              children: [
                                const Icon(Icons.local_airport_outlined),
                                WidgetsSpacer.horizontalSpacer8,
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${airport.name}, ${airport.city}",
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              airport.country,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, .6),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      WidgetsSpacer.horizontalSpacer8,
                                      Text(
                                        airport.iataCode,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          WidgetsSpacer.verticalSpacer8,
                          if (showDivider)
                            const Divider(
                                height: 2, color: AppColors.secondaryColor),
                          WidgetsSpacer.verticalSpacer8,
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is AirportError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
