import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetRemoteDataSource remoteDataSource = sl<BudgetRemoteDataSource>();

  BudgetRepositoryImpl();

  @override
  Future<Either<String, List<BudgetModel>>> getAllBudgets() async {
    try {
      return await remoteDataSource.getAllBudgets();
    } catch (e) {
      return Left("Failed to fetch budgets: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, BudgetModel>> getBudgetById(String id) async {
    try {
      return await remoteDataSource.getBudgetById(id);
    } catch (e) {
      return Left("Failed to fetch budget by ID: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> updateBudget(
       String id, BudgetParams budget) async {
    try {
      return await remoteDataSource.updateBudget(id, budget);
    } catch (e) {
      return Left("Failed to update budget: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, BudgetModel>> getBudgetWithExpenses(
      String id) async {
    try {
      return await remoteDataSource.getBudgetWithExpenses(id);
    } catch (e) {
      return Left("Failed to fetch budget with expenses: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> createBudget(BudgetParams budget) async {
    try {
      return await remoteDataSource.createBudget(budget);
    } catch (e) {
      return Left("Failed to create budget: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> deleteBudget(String id) async {
    try {
      // await remoteDataSource.deleteBudget(id);
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete budget: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<ExpenseModel>>> getAllExpenses() async {
    try {
      return await remoteDataSource.getAllExpenses();
    } catch (e) {
      return Left("Failed to fetch expenses: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, ExpenseModel>> getExpenseById(String id) async {
    try {
      return await remoteDataSource.getExpenseById(id);
    } catch (e) {
      return Left("Failed to fetch expense by ID: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> createExpense(ExpenseParams expense) async {
    try {
      return await remoteDataSource.createExpense(expense);
    } catch (e) {
      return Left("Failed to create expense: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> updateExpense(
      String id, ExpenseParams expense) async {
    try {
      return await remoteDataSource.updateExpense(id, expense);
    } catch (e) {
      return Left("Failed to update expense: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> deleteExpense(String id) async {
    try {
      // await remoteDataSource.deleteExpense(id);
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete expense: ${e.toString()}");
    }
  }
}
