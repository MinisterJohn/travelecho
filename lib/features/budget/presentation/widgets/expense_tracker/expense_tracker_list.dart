import 'package:flutter/material.dart';
import "../../../budget_exports.dart";

class ExpenseTrackerList extends StatelessWidget {
  final Map<String, double> yearlyCategoryPercentages;
  final String selectedYear;

  const ExpenseTrackerList({
    super.key,
    required this.yearlyCategoryPercentages,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: yearlyCategoryPercentages.length ?? 0,
      itemBuilder: (context, index) {
        final category = yearlyCategoryPercentages.keys.elementAt(index);
        final percentage = yearlyCategoryPercentages[category] ?? 0;

        return ListTile(
          minVerticalPadding: 0,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor100,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Icon(
                _getIcon(category).icon,
                size: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          title: Text(category ?? "Unknown"),
          trailing: Text(
            "${percentage.toStringAsFixed(2)}%",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
          ),
        );
      },
    );
  }

  Icon _getIcon(String category) {
    final selectedCategory = expenseCategories.firstWhere(
      (expenseCategory) => expenseCategory.name == category,
    );
    return selectedCategory.icon;
  }
}
