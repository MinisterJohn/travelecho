import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../trip_exports.dart";

class HotelSearchForm extends StatefulWidget {
  const HotelSearchForm({super.key});

  @override
  State<HotelSearchForm> createState() => _HotelSearchFormState();
}

class _HotelSearchFormState extends State<HotelSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adults = 2;
  int _rooms = 1;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _searchHotels() {
    if (_formKey.currentState!.validate()) {
      context.read<HotelBookingBloc>().add(
        SearchHotels(query: _cityController.text.toUpperCase()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City Code (e.g., PAR)',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a city code';
              }
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer16,
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _selectDate(context, true),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _checkInDate == null
                        ? 'Check-in Date'
                        : 'Check-in: ${_checkInDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _selectDate(context, false),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _checkOutDate == null
                        ? 'Check-out Date'
                        : 'Check-out: ${_checkOutDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
              ),
            ],
          ),
          WidgetsSpacer.verticalSpacer16,
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _adults,
                  decoration: const InputDecoration(
                    labelText: 'Adults',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      List.generate(10, (index) => index + 1)
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('$value'),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _adults = value);
                    }
                  },
                ),
              ),
              WidgetsSpacer.horizontalSpacer16,
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _rooms,
                  decoration: const InputDecoration(
                    labelText: 'Rooms',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      List.generate(5, (index) => index + 1)
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('$value'),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _rooms = value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _searchHotels,
              child: const Text('Search Hotels'),
            ),
          ),
        ],
      ),
    );
  }
}
