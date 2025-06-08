part of 'budget_bloc.dart';

abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetsLoaded extends BudgetState {
  final List<BudgetModel> budgets;

  BudgetsLoaded(this.budgets);
}
class SingleBudgetLoaded extends BudgetState {
  final BudgetModel budget;

  SingleBudgetLoaded(this.budget);
}

class BudgetError extends BudgetState {
  final String message;

  BudgetError(this.message);
}

class ExpensesLoaded extends BudgetState {
  final List<ExpenseModel> expenses;

  ExpensesLoaded(this.expenses);
}
