import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../memories_exports.dart';

class MemoryFilterDialog extends StatefulWidget {
  final String? currentLocation;
  final DateTime? currentDate;
  final Function(String?, DateTime?) onApplyFilters;

  const MemoryFilterDialog({
    super.key,
    this.currentLocation,
    this.currentDate,
    required this.onApplyFilters,
  });

  @override
  State<MemoryFilterDialog> createState() => _MemoryFilterDialogState();
}

class _MemoryFilterDialogState extends State<MemoryFilterDialog> {
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _locationController.text = widget.currentLocation ?? '';
    _selectedDate = widget.currentDate;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<DataSearchBloc>(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Memories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,

            // Location filter
            const Text(
              'Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            WidgetsSpacer.verticalSpacer8,
            BlocProvider.value(
              value: sl<DataSearchBloc>(),
              child: LocationSearchField(
                controller: _locationController,
                onLocationSelected: (location) {
                  setState(() {
                    _locationController.text = location;
                  });
                },
              ),
            ),
            WidgetsSpacer.verticalSpacer8,

            // Date filter
            const Text(
              'Sort by Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            WidgetsSpacer.verticalSpacer8,
            InkWell(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LineIcons.calendar,
                      color: AppColors.defaultColor400,
                    ),
                    WidgetsSpacer.horizontalSpacer8,
                    Text(
                      _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Select date to sort by',
                    ),
                  ],
                ),
              ),
            ),
            WidgetsSpacer.verticalSpacer32,

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _locationController.clear();
                        _selectedDate = null;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide.none,
                      textStyle: const TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                    child: const Text('Clear Filters'),
                  ),
                ),
                WidgetsSpacer.horizontalSpacer16,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApplyFilters(
                        _locationController.text.isEmpty
                            ? null
                            : _locationController.text,
                        _selectedDate,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
