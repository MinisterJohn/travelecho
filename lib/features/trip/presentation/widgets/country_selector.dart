import 'package:flutter/material.dart' hide CarouselController;

import '../../trip_exports.dart';

class CountrySelector extends StatefulWidget {
  final Function(Country) onCountrySelected;
  final String? initialCountryCode;

  const CountrySelector({
    super.key,
    required this.onCountrySelected,
    this.initialCountryCode,
  });

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final countries = await CountryService.loadCountries();
      setState(() {
        _countries = countries;
        _filteredCountries = countries;
        _isLoading = false;
      });

      // Set initial country if provided
      if (widget.initialCountryCode != null) {
        final initialCountry = _countries.firstWhere(
          (country) => country.code == widget.initialCountryCode,
          orElse: () => _countries.first,
        );
        _selectedCountry = initialCountry;
        widget.onCountrySelected(initialCountry);
      } else if (_countries.isNotEmpty) {
        _selectedCountry = _countries.first;
        widget.onCountrySelected(_countries.first);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _countries;
      } else {
        _filteredCountries = _countries
            .where((country) =>
                country.name.toLowerCase().contains(query.toLowerCase()) ||
                country.code.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search countries',
            hintText: 'Type to search...',
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _filterCountries('');
                    },
                  )
                : null,
          ),
          onChanged: _filterCountries,
        ),
        const SizedBox(height: 16),

        // Countries list
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_filteredCountries.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No countries found'),
            ),
          )
        else
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = _selectedCountry?.code == country.code;

                return ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country.name),
                  subtitle: Text('+${country.phoneCode}'),
                  selected: isSelected,
                  selectedTileColor: Colors.blue.withOpacity(0.1),
                  onTap: () {
                    setState(() {
                      _selectedCountry = country;
                    });
                    widget.onCountrySelected(country);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
