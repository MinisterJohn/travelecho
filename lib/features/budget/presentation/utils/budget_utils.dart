import '../../budget_exports.dart';

class BudgetUtils {
  static double calculateSpentAmount(List<ExpenseModel>? expenses) {
    if (expenses == null || expenses.isEmpty) return 0.0;
    return expenses.fold(
      0.0,
      (sum, expense) =>
          sum + (expense.amount != 0 ? expense.amount : expense.plannedAmount!),
    );
  }
  static double calculatePlannedExpensesAmount(List<ExpenseModel>? expenses) {
    if (expenses == null || expenses.isEmpty) return 0.0;
    return expenses.fold(
      0.0,
      (sum, expense) =>
          sum + expense.plannedAmount!,
    );
  }
  static double calculateActualSpentAmount(List<ExpenseModel>? expenses) {
    if (expenses == null || expenses.isEmpty) return 0.0;
    return expenses.fold(
      0.0,
      (sum, expense) =>
          sum + expense.amount,
    );
  }

  static int calculateTotalExpenses(List<ExpenseModel>? expenses) {
    return expenses?.length ?? 0;
  }

  static int calculateTotalExpenseCategories(List<ExpenseModel>? expenses) {
    if (expenses == null || expenses.isEmpty) return 0;
    final categories = expenses.map((e) => e.category).toSet();
    return categories.length;
  }

  static String formatAmount(double amount, String symbol) {
    if (amount < 0) {
      return "-${formatAmount(-amount, symbol)}";
    }
    if (amount >= 1000000) {
      return "$symbol ${(amount / 1000000).toStringAsFixed(1)}M";
    } else if (amount >= 1000) {
      return "$symbol ${(amount / 1000).toStringAsFixed(1)}k";
    } else {
      return "$symbol ${amount.toStringAsFixed(2)}";
    }
  }
}
