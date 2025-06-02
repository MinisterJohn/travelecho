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

class GetExpensesEvent extends BudgetEvent {}

class GetExpenseByIdEvent extends BudgetEvent {
  final String id;

  GetExpenseByIdEvent(this.id);
}

class CreateExpenseEvent extends BudgetEvent {
  final ExpenseModel expense;

  CreateExpenseEvent(this.expense);
}

class UpdateExpenseEvent extends BudgetEvent {
  final ExpenseModel expense;
  final String id;

  UpdateExpenseEvent(this.id, this.expense);
}

class DeleteExpenseEvent extends BudgetEvent {
  final String expenseId;

  DeleteExpenseEvent(this.expenseId);
}
