import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

abstract class BudgetRemoteDataSource {
  Future<Either<String, void>> updateBudget(String id, BudgetParams budget);
  Future<Either<String, BudgetModel>> createBudget(BudgetParams budget);
  Future<Either<String, void>> createExpense(ExpenseParams expense);

  Future<Either<String, void>> updateExpense(String id, ExpenseParams expense);
  Future<Either<String, BudgetModel>> getBudgetWithExpenses(String id);
  Future<Either<String, List<ExpenseModel>>> getAllExpenses();
  Future<Either<String, ExpenseModel>> getExpenseById(String id);

  Future<Either<String, List<BudgetModel>>> getAllBudgets();
  Future<Either<String, BudgetModel>> getBudgetById(String id);
}
