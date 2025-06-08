part of 'budget_bloc.dart';

abstract class BudgetEvent {}

class GetAllBudgetsEvent extends BudgetEvent {}

class GetBudgetByIdEvent extends BudgetEvent {
  final String id;

  GetBudgetByIdEvent(this.id);
}

class CreateBudgetEvent extends BudgetEvent {
  final BudgetParams budget;

  CreateBudgetEvent(this.budget);
}

class UpdateBudgetEvent extends BudgetEvent {
  final String id;
  final BudgetParams budget;

  UpdateBudgetEvent(this.id, this.budget);
}

class DeleteBudgetEvent extends BudgetEvent {
  final String id;

  DeleteBudgetEvent(this.id);
}

class GetAllExpensesEvent extends BudgetEvent {}

class GetExpenseByIdEvent extends BudgetEvent {
  final String id;

  GetExpenseByIdEvent(this.id);
}

class GetBudgetWithExpensesEvent extends BudgetEvent {
  final String id;

  GetBudgetWithExpensesEvent(this.id);
}

class CreateExpenseEvent extends BudgetEvent {
  final ExpenseParams expense;

  CreateExpenseEvent(this.expense);
}

class UpdateExpenseEvent extends BudgetEvent {
  final ExpenseParams expense;
  final String id;

  UpdateExpenseEvent(this.id, this.expense);
}

class DeleteExpenseEvent extends BudgetEvent {
  final String expenseId;

  DeleteExpenseEvent(this.expenseId);
}
