import 'package:flutter/material.dart';
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
  final List<Map<String, String>> _suggestedLocations = [
    {
      "title": "Central Park",
      "subtitle": "5th Avenue, Manhattan, New York, NY, USA",
    },
    {
      "title": "Victoria Island",
      "subtitle": "Ahmadu Bello Way, Lagos, Nigeria",
    },
    {
      "title": "Eiffel Tower",
      "subtitle": "Champ de Mars, 5 Avenue Anatole, Paris, France",
    },
    {
      "title": "The Dubai Mall",
      "subtitle": "Downtown Dubai, Dubai, United Arab Emirates",
    },
    {"title": "Marina Bay Sands", "subtitle": "10 Bayfront Ave, Singapore"},
    {
      "title": "Union Square",
      "subtitle": "333 Post St, San Francisco, CA, USA",
    },
    {
      "title": "Ikeja City Mall",
      "subtitle": "Obafemi Awolowo Way, Ikeja, Lagos, Nigeria",
    },
    {
      "title": "Sydney Opera House",
      "subtitle": "Bennelong Point, Sydney NSW, Australia",
    },
    {
      "title": "Mall of Africa",
      "subtitle": "Magwa Cres, Waterval City, Midrand, South Africa",
    },
    {"title": "Oxford Street", "subtitle": "West End, London, United Kingdom"},
  ];

  List<Map<String, String>> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onAddressChanged);
    if (widget.focusAddressField) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_addressFocusNode);
      });
    }
    _filteredSuggestions = [];
  }

  void _onAddressChanged() {
    final query = _addressController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSuggestions = [];
      } else {
        _filteredSuggestions =
            _suggestedLocations
                .where(
                  (loc) =>
                      (loc["title"]?.toLowerCase().contains(query) ?? false) ||
                      (loc["subtitle"]?.toLowerCase().contains(query) ?? false),
                )
                .toList();
      }
    });
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
              // Address field
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
              // Suggestions
              if (_addressController.text.isNotEmpty &&
                  _filteredSuggestions.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredSuggestions.length,
                    itemBuilder: (context, index) {
                      final loc = _filteredSuggestions[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(loc["title"] ?? ""),
                        subtitle: Text(loc["subtitle"] ?? ""),
                        onTap: () {
                          Navigator.pop(context, loc["title"] ?? "");
                        },
                      );
                    },
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _suggestedLocations.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _suggestedLocations.length) {
                        final loc = _suggestedLocations[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(loc["title"] ?? ""),
                          subtitle: Text(loc["subtitle"] ?? ""),
                          onTap: () {
                            Navigator.pop(context, loc["title"] ?? "");
                          },
                        );
                      } else {
                        // Set location on map option
                        return ListTile(
                          leading: const Icon(Icons.add_location_alt_outlined),
                          title: const Text("Set location on map"),
                          onTap: () {
                            // Handle set location on map
                          },
                        );
                      }
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
