import 'package:flutter/material.dart';
import '../../budget_exports.dart';

class ExpenseForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final String selectedCategory;
  final bool isSaving;
  final Function(String) onCategorySelected;
  Widget prefixIcon;

  ExpenseForm({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.noteController,
    required this.selectedCategory,
    required this.isSaving,
    required this.onCategorySelected,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: titleController,
          enabled: !isSaving,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        ExpenseCategorySelector(
          categories: expenseCategories,
          onCategorySelected: onCategorySelected,
          initialCategory: selectedCategory,
        ),
        WidgetsSpacer.verticalSpacer16,
        TextField(
          controller: amountController,
          enabled: !isSaving,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: 'Planned Amount',
            border: const OutlineInputBorder(),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        TextField(
          controller: noteController,
          enabled: !isSaving,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Note',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
