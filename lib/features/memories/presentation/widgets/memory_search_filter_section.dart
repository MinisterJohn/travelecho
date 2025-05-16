import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../memories_exports.dart';
import 'memory_filter_dialog.dart';

class MemorySearchFilterSection extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final String? currentLocation;
  final DateTime? currentDate;
  final Function(String?, DateTime?) onApplyFilters;

  const MemorySearchFilterSection({
    super.key,
    required this.searchController,
    required this.onSearch,
    this.currentLocation,
    this.currentDate,
    required this.onApplyFilters,
  });

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MemoryFilterDialog(
        currentLocation: currentLocation,
        currentDate: currentDate,
        onApplyFilters: onApplyFilters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: MemorySearchBar(
                  controller: searchController,
                  onSearch: onSearch,
                ),
              ),
              WidgetsSpacer.verticalSpacer8,
              IconButton(
                icon: Icon(
                  LineIcons.horizontalSliders,
                  color: currentLocation != null || currentDate != null
                      ? AppColors.primaryColor
                      : AppColors.defaultColor400,
                ),
                onPressed: () => _showFilterDialog(context),
              ),
            ],
          ),
        ),
        if (currentLocation != null || currentDate != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                if (currentLocation != null)
                  Chip(
                    label: Text('Location: $currentLocation'),
                    deleteIcon: const Icon(LineIcons.timesCircleAlt,
                        color: AppColors.defaultColor400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.primaryColor300),
                    ),
                    onDeleted: () => onApplyFilters(null, currentDate),
                  ),
                if (currentDate != null) ...[
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(
                      'Date: ${currentDate!.day}/${currentDate!.month}/${currentDate!.year}',
                    ),
                    deleteIcon: const Icon(LineIcons.timesCircleAlt,
                        color: AppColors.defaultColor400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.primaryColor300),
                    ),
                    onDeleted: () => onApplyFilters(currentLocation, null),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
