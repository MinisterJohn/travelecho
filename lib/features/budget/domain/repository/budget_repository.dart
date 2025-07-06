import "package:dartz/dartz.dart";
import "../../budget_exports.dart";

abstract class BudgetRepository {
  Future<Either<String, void>> createBudget(BudgetParams budget);
  Future<Either<String, void>> updateBudget(String id, BudgetParams budget);
  Future<Either<String, void>> deleteBudget(String id);

  Future<Either<String, ExpenseModel>> createExpense(ExpenseParams expense);
  Future<Either<String, ExpenseModel>> updateExpense(String id, ExpenseParams expense);
  Future<Either<String, void>> deleteExpense(String id);
  Future<Either<String, String>> uploadReceipt({
    required String expenseId,
    required dynamic filePath,
  });

  Future<Either<String, BudgetModel>> getBudgetWithExpenses(String id);
  Future<Either<String, List<ExpenseModel>>> getAllExpenses();
  Future<Either<String, ExpenseModel>> getExpenseById(String id);
  Future<Either<String, List<BudgetModel>>> getAllBudgets({
    String? sort,
    required int limit,
    required int skip,
  });
  Future<Either<String, BudgetModel>> getBudgetById(String id);
}
