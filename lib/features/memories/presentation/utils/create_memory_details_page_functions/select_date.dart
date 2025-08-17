import 'package:flutter/material.dart';

Future<void> selectDate({
  required BuildContext context,
  required DateTime? selectedDate,
  required Function(DateTime) onDateSelected,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    onDateSelected(picked);
  }
}
