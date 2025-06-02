import "package:dartz/dartz.dart";
import "../../budget_exports.dart";

abstract class BudgetRepository {
  Future<Either<String, List<BudgetModel>>> getAllBudgets();
  Future<Either<String, BudgetModel>> getBudgetById(String id);
  Future<Either<String, void>> updateBudget(
    String id,
    BudgetParams budget,
  );
  Future<Either<String, Map<String, dynamic>>> getBudgetWithExpenses(String id);
  Future<Either<String, void>> createBudget(
    BudgetParams budget,
  );
  Future<Either<String, void>> deleteBudget(String id);

  Future<Either<String, List<ExpenseModel>>> getAllExpenses();
  Future<Either<String, ExpenseModel>> getExpenseById(String id);
  Future<Either<String, void>> createExpense(ExpenseModel expense);
  Future<Either<String, void>> updateExpense(String id, ExpenseModel expense);
  Future<Either<String, void>> deleteExpense(String id);
}
