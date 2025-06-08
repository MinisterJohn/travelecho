import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../memories_exports.dart';

class DetailsTab extends StatelessWidget {
  final MemoryModel memory;

  const DetailsTab({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Memory Details", style: TextStyle(fontSize: 20)),
          WidgetsSpacer.verticalSpacer16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MemoryDetailRow(
                icon: LineIcons.mapMarker,
                label: 'Event Location:',
                value: memory.location,
              ),
              MemoryDetailRow(
                icon: LineIcons.calendar,
                label: 'Date of Event:',
                value: formatDate(memory.date),
              ),
              MemoryDetailRow(
                icon: LineIcons.calendarPlusAlt,
                label: 'Memory was Created on:',
                value: formatDate(memory.createdAt),
              ),
              MemoryDetailRow(
                icon: LineIcons.calendarCheckAlt,
                label: 'Memory was Last Updated on:',
                value: formatDate(memory.updatedAt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MemoryDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MemoryDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 16),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(value),
          ),
          WidgetsSpacer.verticalSpacer8,
          Divider(height: 1, color: AppColors.primaryColor100),
        ],
      ),
    );
  }
}
