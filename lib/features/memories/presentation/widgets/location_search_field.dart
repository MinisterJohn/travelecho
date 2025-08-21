import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../memories_exports.dart';

class LocationSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onLocationSelected;

  const LocationSearchField({
    super.key,
    required this.controller,
    required this.onLocationSelected,
  });

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  bool _hasSelected = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (_hasSelected) return; // 🔒 Stop triggering search if already selected

    if (widget.controller.text.isNotEmpty) {
      context.read<DataSearchBloc>().add(
            LocationListRequested(locationHint: widget.controller.text),
          );
    } else {
      context.read<DataSearchBloc>().add(
            const ClearSearchResults(type: SearchType.location),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            hintText: 'Enter location',
            prefixIcon: Icon(LineIcons.mapMarker, color: AppColors.defaultColor400),
          ),
          onChanged: (val) {
            if (!_hasSelected) return;
            // If user edits text manually, allow search again
            setState(() => _hasSelected = false);
          },
        ),
        BlocBuilder<DataSearchBloc, DataSearchState>(
          builder: (context, state) {
            if (!_hasSelected && state is LocationListLoaded) {
              return Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final location = state.locations[index];
                    return ListTile(
                      title: Text(location.location),
                      onTap: () {
                        widget.controller.text = location.location;
                        widget.onLocationSelected(location.location);
                        setState(() => _hasSelected = true); // ✅ Lock list
                        context.read<DataSearchBloc>().add(
                              const ClearSearchResults(type: SearchType.location),
                            );
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
