import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TravelDocumentCountryDropdown extends StatefulWidget {
  final String? selectedCountry;
  final ValueChanged<String> onSelected;

  const TravelDocumentCountryDropdown({
    super.key,
    required this.selectedCountry,
    required this.onSelected,
  });

  @override
  State<TravelDocumentCountryDropdown> createState() =>
      _TravelDocumentCountryDropdownState();
}

class _TravelDocumentCountryDropdownState
    extends State<TravelDocumentCountryDropdown> {
  List<Map<String, dynamic>> countries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final String data = await rootBundle.loadString(
      'assets/json/countries.json',
    );
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      countries = jsonResult.cast<Map<String, dynamic>>();
      isLoading = false;
    });
  }

  void _showTravelDocumentCountryDropdown(BuildContext context) async {
    String search = '';
    List<Map<String, dynamic>> localFiltered = List.from(countries);

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Search Country",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      search = value;
                      setModalState(() {
                        localFiltered =
                            countries
                                .where(
                                  (country) =>
                                      country['name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(search.toLowerCase()) ||
                                      (country['code']
                                                  ?.toString()
                                                  .toLowerCase() ??
                                              '')
                                          .contains(search.toLowerCase()),
                                )
                                .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: localFiltered.length,
                      itemBuilder: (context, index) {
                        final country = localFiltered[index];
                        return ListTile(
                          leading: Text(
                            country['flag'] ?? '',
                            style: const TextStyle(fontSize: 22),
                          ),
                          title: Text(country['name']),
                          subtitle: Text(country['code']),
                          onTap: () {
                            Navigator.pop(context, country['name']);
                          },
                          selected: widget.selectedCountry == country['name'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (selected != null) {
      widget.onSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : GestureDetector(
          onTap: () => _showTravelDocumentCountryDropdown(context),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nationality',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              controller: TextEditingController(
                text: widget.selectedCountry ?? '',
              ),
              validator:
                  (value) =>
                      (widget.selectedCountry == null ||
                              widget.selectedCountry!.isEmpty)
                          ? 'Required'
                          : null,
            ),
          ),
        );
  }
}
