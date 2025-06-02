import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

abstract class BudgetRemoteDataSource {
  Future<Either<String, List<BudgetModel>>> getAllBudgets();
  Future<Either<String, BudgetModel>> getBudgetById(String id);
  Future<Either<String, void>> updateBudget(
      String id, BudgetParams budget);
  Future<Either<String, BudgetModel>> createBudget(BudgetParams budget);
  Future<Either<String, Map<String, dynamic>>> getBudgetWithExpenses(String id);
  Future<Either<String, List<ExpenseModel>>> getAllExpenses();
  Future<Either<String, ExpenseModel>> getExpenseById(String id);
  Future<Either<String, void>> createExpense(Map<String, dynamic> data);
  Future<Either<String, void>> updateExpense(
      String id, Map<String, dynamic> data);
}
