part of 'budget_bloc.dart';

abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetsLoaded extends BudgetState {
  final List<BudgetModel> budgets;
  final bool hasMore;
  final int currentPage;
  // final String? deletingMemoryId;
  final bool isSearching;
  final bool append;

  BudgetsLoaded({
    required this.budgets,
    this.hasMore = false,
    this.currentPage = 1,
    // this.deletingMemoryId,
    this.isSearching = false,
    this.append = false, // Default to false
  });
}

class SingleBudgetLoaded extends BudgetState {
  final BudgetModel budget;

  SingleBudgetLoaded(this.budget);
}

class ExpenseSaved extends BudgetState {}


class BudgetError extends BudgetState {
  final String message;

  BudgetError(this.message);
}

class ExpensesLoaded extends BudgetState {
  final List<ExpenseModel> expenses;

  ExpensesLoaded(this.expenses);
}
