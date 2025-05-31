import 'package:flutter/material.dart' hide CarouselController;
import "../../memories_exports.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class MemoryFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final DateTime? selectedDate;
  final bool isPublic;
  final ValueChanged<bool?> onPublicChanged;
  final VoidCallback onDateTap;

  const MemoryFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.locationController,
    required this.selectedDate,
    required this.isPublic,
    required this.onPublicChanged,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a title to describe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.size16,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Enter title',
            hintStyle: const TextStyle(color: AppColors.secondaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(fontSize: 16),
          maxLines: 1,
        ),
        WidgetsSpacer.verticalSpacer16,
        Text(
          'Add a description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.size16,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'Enter description',
            hintStyle: const TextStyle(color: AppColors.secondaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(fontSize: 16),
          maxLines: 3,
        ),
        WidgetsSpacer.verticalSpacer16,
        Text(
          'Add location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.size16,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        BlocProvider.value(
          value: sl<DataSearchBloc>(),
          child: LocationSearchField(
            controller: locationController,
            onLocationSelected: (location) {
              locationController.text = location;
            },
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        Text(
          'Select date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.size16,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        InkWell(
          onTap: onDateTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select date',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Make this memory public',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Transform.scale(
            scale: 0.75, // Adjust this to control switch size
            child: Switch(
              value: isPublic,
              onChanged: onPublicChanged,
              activeColor: AppColors.primaryColor,
              activeTrackColor: AppColors.primaryColor100,
              trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return AppColors.defaultColor;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
