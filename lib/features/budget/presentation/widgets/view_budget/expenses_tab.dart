import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class ExpensesTab extends StatelessWidget {
  final BudgetModel updatedBudget;
  final CurrencyInfo currencyInfo;

  const ExpensesTab({
    super.key,
    required this.updatedBudget,
    required this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    final expenses = updatedBudget.expenses ?? [];

    if (expenses.isEmpty) {
      return EmptyScreen(
        description:
            "No expense yet on this budget.\n You can create an expense and track it",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        final category = expenseCategories.firstWhere(
          (cat) => cat.name == expense.category,
          orElse:
              () => ExpenseCategoryModel(
                name: expense.category,
                description: "Unknown category",
                icon: const Icon(Icons.help_outline),
                color: AppColors.defaultColor400,
              ),
        );

        String truncatedDescription =
            category.description.length > 20
                ? '${category.description.substring(0, 17)}...'
                : category.description;

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(top: 4),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(
                  category.icon.icon,
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            title: Text(expense.title),
            subtitle: Text(
              truncatedDescription,
              style: TextStyle(color: AppColors.defaultColor400),
            ),
            trailing: Text(
              "-${BudgetUtils.formatAmount((expense.amount != 0 ? expense.amount : expense.plannedAmount!), currencyInfo.symbol)}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.errorColor,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
