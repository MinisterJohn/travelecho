import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features_exports.dart';

class CarRentalsLocationSelectionScreen extends StatefulWidget {
  final bool focusAddressField;
  const CarRentalsLocationSelectionScreen({
    super.key,
    this.focusAddressField = false,
  });

  @override
  State<CarRentalsLocationSelectionScreen> createState() =>
      _CarRentalsLocationSelectionScreenState();
}

class _CarRentalsLocationSelectionScreenState
    extends State<CarRentalsLocationSelectionScreen> {
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onAddressChanged);
    if (widget.focusAddressField) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_addressFocusNode);
      });
    }
  }

  void _onAddressChanged() {
    final query = _addressController.text.trim();
    context.read<LocationSuggestionCubit>().fetchSuggestions(query);
  }

  @override
  void dispose() {
    _addressController.removeListener(_onAddressChanged);
    _addressController.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _addressController,
                      focusNode: _addressFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        hintText: "Enter address",
                      ),
                    ),
                  ),
                ],
              ),
              WidgetsSpacer.verticalSpacer32,
              Expanded(
                child: BlocBuilder<
                  LocationSuggestionCubit,
                  LocationSuggestionState
                >(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LocationLoaded) {
                      if (state.suggestions.isEmpty) {
                        return const Center(child: Text("No locations found."));
                      }
                      return ListView.builder(
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, index) {
                          final loc = state.suggestions[index];
                          return ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: Text(loc.name),
                            subtitle: Text(loc.address),
                            onTap: () {
                              Navigator.pop(context, loc.name);
                            },
                          );
                        },
                      );
                    } else if (state is LocationError) {
                      return Center(child: Text(state.message));
                    }
                    // Initial state or empty query
                    return const Center(
                      child: Text("Type to search locations"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
