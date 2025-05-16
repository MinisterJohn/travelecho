import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../budget_exports.dart';

class BudgetApiService {
  final DioClient _dioClient;

  BudgetApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<BudgetFailure, void>> createBudget(Budget budget) async {
    try {
      final response = await _dioClient.post(
        '/api/budgets',
        data: budget.toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(null);
      } else {
        return const Left(BudgetCreationFailure('Failed to create budget'));
      }
    } on DioException catch (e) {
      return Left(
          BudgetCreationFailure(e.message ?? 'Failed to create budget'));
    }
  }

  Future<Either<BudgetFailure, void>> updateBudget(Budget budget) async {
    try {
      final response = await _dioClient.put(
        '/api/budgets/${budget.id}',
        data: budget.toJson(),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(BudgetUpdateFailure('Failed to update budget'));
      }
    } on DioException catch (e) {
      return Left(BudgetUpdateFailure(e.message ?? 'Failed to update budget'));
    }
  }

  Future<Either<BudgetFailure, void>> deleteBudget(String budgetId) async {
    try {
      final response = await _dioClient.delete('/api/budgets/$budgetId');

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(BudgetDeletionFailure('Failed to delete budget'));
      }
    } on DioException catch (e) {
      return Left(
          BudgetDeletionFailure(e.message ?? 'Failed to delete budget'));
    }
  }

  Future<Either<BudgetFailure, List<Budget>>> getBudgets() async {
    try {
      final response = await _dioClient.get('/api/budgets');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final budgets = data.map((json) => Budget.fromJson(json)).toList();
        return Right(budgets);
      } else {
        return const Left(BudgetFetchFailure('Failed to fetch budgets'));
      }
    } on DioException catch (e) {
      return Left(BudgetFetchFailure(e.message ?? 'Failed to fetch budgets'));
    }
  }

  Future<Either<BudgetFailure, Budget>> getBudgetById(String budgetId) async {
    try {
      final response = await _dioClient.get('/api/budgets/$budgetId');

      if (response.statusCode == 200) {
        final budget = Budget.fromJson(response.data);
        return Right(budget);
      } else {
        return const Left(BudgetFetchFailure('Failed to fetch budget'));
      }
    } on DioException catch (e) {
      return Left(BudgetFetchFailure(e.message ?? 'Failed to fetch budget'));
    }
  }
}
