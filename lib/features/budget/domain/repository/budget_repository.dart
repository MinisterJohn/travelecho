import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

abstract class BudgetRepository {
  Future<Either<BudgetFailure, void>> createBudget(Budget budget);
  Future<Either<BudgetFailure, void>> updateBudget(Budget budget);
  Future<Either<BudgetFailure, void>> deleteBudget(String budgetId);
  Future<Either<BudgetFailure, List<Budget>>> getBudgets();
  Future<Either<BudgetFailure, Budget>> getBudgetById(String budgetId);
} 