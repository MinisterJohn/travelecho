import 'dart:async';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../profile_exports.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog({super.key});

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  final TextEditingController locationController = TextEditingController();
  Timer? debounce;
  bool _isUpdating = false;
  String selectedLocation = "";
  bool _showLocationSuggestions = false;

  void searchForLocations(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (!context.mounted) return;
      if (value.isEmpty || value.length <= 1) {
        setState(() => _showLocationSuggestions = false);

        context.read<DataSearchBloc>().add(
          const ClearSearchResults(type: SearchType.location),
        );
      } else {
        setState(() => _showLocationSuggestions = true);
        context.read<DataSearchBloc>().add(
          LocationListRequested(locationHint: value),
        );
      }
    });
  }

  Future<void> _updateLocation(String location) async {
    if (_isUpdating) return;
    setState(() => _isUpdating = true);
    try {
      // pr/int()
      context.read<ProfileBloc>().add(
        ProfileUpdateRequested(location, ProfileUpdateKey.location),
      );
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        DisplayMessage.errorMessage("Failed to update location: $e", context);
      }
    } finally {
      if (context.mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Where I live",
          style: TextStyle(
            fontSize: FontSize.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            LineIcons.timesCircleAlt,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationField() {
    return BlocBuilder<DataSearchBloc, DataSearchState>(
      builder: (context, state) {
        return TextField(
          controller: locationController,
          enabled: !_isUpdating,
          onChanged: searchForLocations,
          decoration: InputDecoration(
            fillColor: AppColors.primaryColor100,
            filled: true,
            suffixIcon:
                state is DataSearchLoading
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                    : null,
            prefixIcon:
                _isUpdating
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(
                      LineIcons.mapMarker,
                      color: AppColors.primaryColor,
                    ),
            hintText: "Enter your location",

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        );
      },
    );
  }

  Widget _relatedLocationsWidget(
    List<LocationModel> locations,
    BuildContext context,
    TextEditingController locationController,
    bool isUpdating,
  ) {
    if (locations.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Text("No locations found"),
            WidgetsSpacer.verticalSpacer16,
            OutlinedButton(
              onPressed:
                  isUpdating
                      ? null
                      : () {
                        final location = locationController.text.trim();
                        if (location.isNotEmpty) {
                          setState(() {
                            selectedLocation = location;
                          });
                        }
                      },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                side: const BorderSide(color: AppColors.primaryColor),
              ),
              child: const Text("Add Custom Location"),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.defaultColor100,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(maxHeight: 200),
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return ListTile(
              title: Text(
                location.location,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.zero,
              onTap:
                  isUpdating
                      ? null
                      : () {
                        locationController.clear();
                        setState(() {
                          selectedLocation = location.location;
                          _showLocationSuggestions = false;
                        });
                        context.read<DataSearchBloc>().add(
                          const ClearSearchResults(type: SearchType.location),
                        );
                      },
            );
          },
        ),
      ),
    );
  }

  Widget _selectedLocationWidget(String selectedLocation) {
    return Container(
      color: AppColors.primaryColor100,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Text(
        selectedLocation,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap:
          _isUpdating
              ? null
              : () {
                if (selectedLocation.isNotEmpty) {
                  _updateLocation(selectedLocation);
                }
              },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color:
              _isUpdating
                  ? AppColors.primaryColor.withOpacity(0.5)
                  : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child:
              _isUpdating
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ProfileBloc>()),
        BlocProvider.value(value: sl<DataSearchBloc>()),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20.0),
          _buildLocationField(),
          const SizedBox(height: 10.0),
          if (_showLocationSuggestions)
            BlocBuilder<DataSearchBloc, DataSearchState>(
              builder: (context, state) {
                if (state is LocationListLoaded) {
                  return _relatedLocationsWidget(
                    state.locations,
                    context,
                    locationController,
                    _isUpdating,
                  );
                } else if (state is DataSearchError) {
                  DisplayMessage.errorMessage(
                    "Error: //${state.message}",
                    context,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          if (locationController.text.isEmpty && selectedLocation.isNotEmpty)
            _selectedLocationWidget(selectedLocation),
          WidgetsSpacer.spacer,
          _buildAddButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    debounce?.cancel();
    super.dispose();
  }
}

void showWhereILiveDialog(BuildContext context) {
  showDraggableBottomModal(
    context,
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ProfileBloc>()),
        BlocProvider.value(value: sl<DataSearchBloc>()),
      ],
      child: const LocationDialog(),
    ),
  );
}
