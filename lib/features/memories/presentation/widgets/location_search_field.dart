import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../features/profile/presentation/blocs/data_search_bloc.dart';
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
    if (widget.controller.text.isNotEmpty) {
      context.read<DataSearchBloc>().add(
            LocationListRequested(locationHint: widget.controller.text),
          );
    } else {
      context.read<DataSearchBloc>().add(
            ClearSearchResults(type: SearchType.location),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Enter location',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(LineIcons.mapMarker, color: AppColors.defaultColor400),
          ),
        ),
        BlocBuilder<DataSearchBloc, DataSearchState>(
          builder: (context, state) {
            if (state is LocationListLoaded) {
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
                        context.read<DataSearchBloc>().add(
                              ClearSearchResults(type: SearchType.location),
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
