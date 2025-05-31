import 'dart:async';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../trip_exports.dart';

class AirportSearchSection extends StatefulWidget {
  final Function(Airport) onAirportSelected;
  final String title;
  final String hintText;
  final bool isDestination;
  final double maxHeight;
  final bool showDivider;
  final TextEditingController searchController;
  final String? selectedAirportCode;
  final String? selectedAirportName;

  const AirportSearchSection({
    super.key,
    required this.onAirportSelected,
    this.title = "Where to?",
    this.hintText = "Enter your location",
    this.isDestination = false,
    this.maxHeight = 300,
    this.showDivider = true,
    required this.searchController,
    this.selectedAirportCode,
    this.selectedAirportName,
  });

  @override
  State<AirportSearchSection> createState() => _AirportSearchSectionState();
}

class _AirportSearchSectionState extends State<AirportSearchSection> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    // _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String country, String airport) {
    if (airport.isNotEmpty) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        context.read<AirportBloc>().add(SearchAirportEvent(airport));
      });
    } else {
      context.read<AirportBloc>().add(ClearAirportSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        WidgetsSpacer.verticalSpacer8,
        TextField(
          controller: widget.searchController,
          onChanged: (value) => _onSearchChanged("", value),
          decoration: InputDecoration(
            prefixIcon: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: widget.isDestination
                    ? const Icon(Icons.search, size: 18)
                    : const FaIcon(FontAwesomeIcons.locationCrosshairs,
                        size: 18),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(maxWidth: 40),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            hintText: widget.hintText,
          ),
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
        ),

        // Show previously selected airport if available
        if (widget.selectedAirportCode != null &&
            widget.selectedAirportName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.isDestination
                        ? Icons.flight_land_outlined
                        : Icons.flight_takeoff_outlined,
                    size: 16,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Currently selected:",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          "${widget.selectedAirportName} (${widget.selectedAirportCode})",
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
          ),

        WidgetsSpacer.verticalSpacer16,
        AirportSearchResults(
          onAirportSelected: widget.onAirportSelected,
          title: "Search Results",
          isDestination: widget.isDestination,
          maxHeight: widget.maxHeight,
          showDivider: widget.showDivider,
        ),
      ],
    );
  }
}
