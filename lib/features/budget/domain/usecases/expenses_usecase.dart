import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class CreateExpenseUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  CreateExpenseUseCase();

  Future<Either<String, ExpenseModel>> call(ExpenseParams expense) {
    return repository.createExpense(expense);
  }
}

class UpdateExpenseUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  UpdateExpenseUseCase();

  Future<Either<String, ExpenseModel>> call(String id, ExpenseParams expense) {
    return repository.updateExpense(id, expense);
  }
}

class DeleteExpenseUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  DeleteExpenseUseCase();

  Future<Either<String, void>> call(String id) {
    return repository.deleteExpense(id);
  }
}

class UploadExpenseReceiptUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  UploadExpenseReceiptUseCase();

  Future<Either<String, void>> call(String expenseId, dynamic filePath) {
    print("filePath $filePath");
    return repository.uploadReceipt(expenseId: expenseId, filePath: filePath);
  }
}

class GetExpensesUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetExpensesUseCase();

  Future<Either<String, List<ExpenseModel>>> call() {
    return repository.getAllExpenses();
  }
}

class GetExpenseByIdUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetExpenseByIdUseCase();

  Future<Either<String, ExpenseModel>> call(String id) {
    return repository.getExpenseById(id);
  }
}
