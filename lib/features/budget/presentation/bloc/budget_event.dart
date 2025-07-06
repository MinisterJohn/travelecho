part of 'budget_bloc.dart';

abstract class BudgetEvent {}

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
  final String budgetId;
  final String expenseId;

  DeleteExpenseEvent(this.budgetId, this.expenseId);
}

class UploadExpenseReceiptEvent extends BudgetEvent {
  final String expenseId;
  final String filePath;

  UploadExpenseReceiptEvent(this.expenseId, this.filePath);
}

class GetAllBudgetsEvent extends BudgetEvent {
  String? sort;
  int limit;
  int skip;
  final bool append;
  GetAllBudgetsEvent({
    this.sort,
    this.limit = 10,
    this.skip = 0,
    this.append = false,
  });
}

class GetBudgetByIdEvent extends BudgetEvent {
  final String id;

  GetBudgetByIdEvent(this.id);
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
