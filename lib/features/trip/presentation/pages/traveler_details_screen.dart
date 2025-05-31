import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../trip_exports.dart";

class TravelerDetailsScreen extends StatefulWidget {
  const TravelerDetailsScreen({super.key});

  @override
  State<TravelerDetailsScreen> createState() => _TravelerDetailsScreenState();
}

class _TravelerDetailsScreenState extends State<TravelerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, DateTime?> _selectedDates = {};
  final Map<String, String> _selectedDocumentTypes = {};
  final Map<String, Country> _selectedPhoneCountries = {};
  final Map<String, Country> _selectedNationalities = {};
  final Map<String, Country> _selectedIssuanceCountries = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final state = context.read<FlightBookingBloc>().state;
    if (state is FlightBookingSuccess) {
      for (var traveler in state.flightBooking.travelers) {
        _controllers['${traveler.id}_firstName'] = TextEditingController();
        _controllers['${traveler.id}_lastName'] = TextEditingController();
        _controllers['${traveler.id}_dateOfBirth'] = TextEditingController();
        _controllers['${traveler.id}_phoneNumber'] = TextEditingController();
        _controllers['${traveler.id}_documentNumber'] = TextEditingController();
        _controllers['${traveler.id}_documentExpiry'] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, String travelerId, bool isDateOfBirth) async {
    final DateTime now = DateTime.now();
    final DateTime? currentValue = _selectedDates[travelerId];

    // Define date ranges
    final DateTime firstDate = isDateOfBirth ? DateTime(1900) : now;
    final DateTime lastDate = isDateOfBirth ? now : DateTime(2100);

    // Ensure initial date is within valid range
    DateTime initialDate;
    if (currentValue != null) {
      if (currentValue.isBefore(firstDate)) {
        initialDate = firstDate;
      } else if (currentValue.isAfter(lastDate)) {
        initialDate = lastDate;
      } else {
        initialDate = currentValue;
      }
    } else {
      initialDate = isDateOfBirth ? DateTime(2000) : now;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDates[travelerId]) {
      setState(() {
        _selectedDates[travelerId] = picked;
        final controllerKey = isDateOfBirth
            ? '${travelerId}_dateOfBirth'
            : '${travelerId}_documentExpiry';
        _controllers[controllerKey]?.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _showCountrySelector(BuildContext context, String travelerId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Country',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CountrySelector(
                initialCountryCode: _selectedPhoneCountries[travelerId]?.code,
                onCountrySelected: (country) {
                  setState(() {
                    _selectedPhoneCountries[travelerId] = country;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traveler Details'),
      ),
      body: BlocBuilder<FlightBookingBloc, FlightBookingState>(
        builder: (context, state) {
          if (state is FlightBookingSuccess) {
            return Form(
              key: _formKey,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.flightBooking.travelers.length,
                itemBuilder: (context, index) {
                  final traveler = state.flightBooking.travelers[index];
                  return _buildTravelerForm(traveler, index + 1);
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Continue to Preview'),
        ),
      ),
    );
  }

  Widget _buildTravelerForm(Traveler traveler, int travelerNumber) {
    // Get traveler type display name
    String travelerTypeDisplay = _getTravelerTypeDisplay(traveler.travelerType);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traveler - $travelerTypeDisplay $travelerNumber',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controllers['${traveler.id}_firstName'],
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _controllers['${traveler.id}_lastName'],
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controllers['${traveler.id}_dateOfBirth'],
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, traveler.id, true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select date of birth';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Phone number with country selector
            Row(
              children: [
                // Country selector button
                SizedBox(
                  width: 100,
                  child: OutlinedButton(
                    onPressed: () => _showCountrySelector(context, traveler.id),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedPhoneCountries[traveler.id]?.flag ?? '🌍',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '+${_selectedPhoneCountries[traveler.id]?.phoneCode ?? '1'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Phone number field
                Expanded(
                  child: TextFormField(
                    controller: _controllers['${traveler.id}_phoneNumber'],
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedDocumentTypes[traveler.id],
              decoration: const InputDecoration(
                labelText: 'Document Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'PASSPORT', child: Text('Passport')),
                DropdownMenuItem(value: 'ID_CARD', child: Text('ID Card')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDocumentTypes[traveler.id] = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select document type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controllers['${traveler.id}_documentNumber'],
              decoration: const InputDecoration(
                labelText: 'Document Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter document number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controllers['${traveler.id}_documentExpiry'],
              decoration: const InputDecoration(
                labelText: 'Document Expiry Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, traveler.id, false),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select expiry date';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CountryDropdown(
              value: _selectedIssuanceCountries[traveler.id]?.code,
              onChanged: (Country country) {
                setState(() {
                  _selectedIssuanceCountries[traveler.id] = country;
                });
              },
              hintText: 'Select Document Issuance Country',
              errorText: _selectedIssuanceCountries[traveler.id] == null
                  ? 'Please select issuance country'
                  : null,
            ),
            const SizedBox(height: 16),
            CountryDropdown(
              value: _selectedNationalities[traveler.id]?.code,
              onChanged: (Country country) {
                setState(() {
                  _selectedNationalities[traveler.id] = country;
                });
              },
              hintText: 'Select Nationality',
              errorText: _selectedNationalities[traveler.id] == null
                  ? 'Please select nationality'
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  String _getTravelerTypeDisplay(String travelerType) {
    switch (travelerType.toUpperCase()) {
      case 'ADULT':
        return 'Adult';
      case 'CHILD':
        return 'Child';
      case 'INFANT':
        return 'Infant';
      case 'SENIOR':
        return 'Senior';
      case 'YOUTH':
        return 'Youth';
      default:
        return travelerType;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final state = context.read<FlightBookingBloc>().state;
      if (state is FlightBookingSuccess) {
        for (var traveler in state.flightBooking.travelers) {
          final dateOfBirth = _controllers['${traveler.id}_dateOfBirth']!.text;
          final expiryDate =
              _controllers['${traveler.id}_documentExpiry']!.text;

          // Get the selected country for phone number
          final selectedCountry = _selectedPhoneCountries[traveler.id];
          final countryCallingCode = selectedCountry?.phoneCode ?? '1';

          final details = TravelerDetails(
            id: traveler.id,
            dateOfBirth: dateOfBirth,
            name: TravelerName(
              firstName: _controllers['${traveler.id}_firstName']!.text,
              lastName: _controllers['${traveler.id}_lastName']!.text,
            ),
            contact: TravelerContact(
              phones: [
                TravelerPhone(
                  countryCallingCode: countryCallingCode,
                  number: _controllers['${traveler.id}_phoneNumber']!.text,
                ),
              ],
            ),
            documents: [
              TravelerDocument(
                documentType: _selectedDocumentTypes[traveler.id]!,
                number: _controllers['${traveler.id}_documentNumber']!.text,
                expiryDate: expiryDate,
                issuanceCountry:
                    _selectedIssuanceCountries[traveler.id]?.code ?? '',
                nationality: _selectedNationalities[traveler.id]?.code ?? '',
                holder: true,
              ),
            ],
          );

          context.read<FlightBookingBloc>().updateTravelerDetails(
                travelerId: traveler.id,
                details: details,
              );
        }

        AppNavigator.push(
          context,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: sl<FlightBookingBloc>()),
            ],
            child: const FlightBookingPreview(),
          ),
        );
      }
    }
  }
}
