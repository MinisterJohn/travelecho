import 'package:flutter/material.dart';
import "../../../budget_exports.dart";

class ExpenseTrackerHeader extends StatelessWidget {
  final String selectedMonth;
  final String selectedYear;
  final List<String> expenseMonths;
  final List<String> expenseYears;
  final Function(String, String) onMonthYearChanged;

  const ExpenseTrackerHeader({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.expenseMonths,
    required this.expenseYears,
    required this.onMonthYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.defaultColor100.withOpacity(0.01),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 24,
              color: AppColors.defaultColor400,
            ),
            onPressed: () {
              final currentMonthIndex = expenseMonths.indexOf(selectedMonth);
              if (currentMonthIndex > 0) {
                onMonthYearChanged(
                  expenseMonths[currentMonthIndex - 1],
                  selectedYear,
                );
              } else {
                final currentYearIndex = expenseYears.indexOf(selectedYear);
                if (currentYearIndex > 0) {
                  onMonthYearChanged(
                    expenseMonths.last,
                    expenseYears[currentYearIndex - 1],
                  );
                }
              }
            },
          ),
          Column(
            children: [
              Text(
                "${monthNames[int.parse(selectedMonth) - 1]} $selectedYear",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text('you made'),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: AppColors.defaultColor400,
            ),
            onPressed: () {
              final currentMonthIndex = expenseMonths.indexOf(selectedMonth);
              if (currentMonthIndex < expenseMonths.length - 1) {
                onMonthYearChanged(
                  expenseMonths[currentMonthIndex + 1],
                  selectedYear,
                );
              } else {
                final currentYearIndex = expenseYears.indexOf(selectedYear);
                if (currentYearIndex < expenseYears.length - 1) {
                  onMonthYearChanged(
                    expenseMonths.first,
                    expenseYears[currentYearIndex + 1],
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
