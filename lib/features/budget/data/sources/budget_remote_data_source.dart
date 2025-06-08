import 'package:dio/dio.dart';
import 'package:logger/logger.dart'; // Added Logger import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

import "../../budget_exports.dart";

class BudgetRemoteDataSourceImpl implements BudgetRemoteDataSource {
  final DioClient dio = sl<DioClient>();
  final Logger logger = Logger(); // Added Logger instance

  BudgetRemoteDataSourceImpl();
  final SharedPreferences _prefs = sl<SharedPreferences>();

  Future<Options> _getOptions() async {
    final token = _prefs.getString('token');
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return e.response?.data['message'] ?? 'An error occurred.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  /// Create a new budget
  @override
  Future<Either<String, BudgetModel>> createBudget(BudgetParams budget) async {
    try {
      final storedUserId = _prefs.getString('user_id');
      if (storedUserId == null || storedUserId.isEmpty) {
        logger.e("User ID is null or empty. Cannot create budget.");
        return const Left(
          'User ID is required to create a budget. Please log in again.',
        );
      }
      print("Creating budget for user ID: $storedUserId");

      final options = await _getOptions();
      final response = await dio.post(
        ApiUrl.budgetURL,
        data: {"user": storedUserId, ...budget.toJson()},
        options: options,
      );
      print("Budget created successfully: ${response.data["budget"]}");
      return Right(BudgetModel.fromJson(response.data["budget"]));
    } on DioException catch (e) {
      logger.e("Error creating budget: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Update a budget
  @override
  Future<Either<String, void>> updateBudget(
    String id,
    BudgetParams budget,
  ) async {
    try {
      final storedUserId = _prefs.getString('user_id');

      final options = await _getOptions();
      await dio.put(
        ApiUrl.dynamicBudgetURL(id),
        data: {...budget.toJson(), "user": storedUserId},
        options: options,
      );
      return const Right(null);
    } on DioException catch (e) {
      logger.e("Error updating budget ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Create a new expense
  @override
  Future<Either<String, void>> createExpense(ExpenseParams expense) async {
    try {
      final storedUserId = _prefs.getString('user_id');

      final options = await _getOptions();
      await dio.post(
        ApiUrl.expenseURL,
        data: {"user": storedUserId, ...expense.toJson()},
        options: options,
      );
      return const Right(null);
    } on DioException catch (e) {
      logger.e("Error creating expense: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Update an expense
  @override
  Future<Either<String, void>> updateExpense(
    String id,
    ExpenseParams expense,
  ) async {
    try {
      final options = await _getOptions();
      final storedUserId = _prefs.getString('user_id');
      await dio.put(
        ApiUrl.dynamicExpenseURL(id),
        data: {"user": storedUserId, ...expense.toJson()},
        options: options,
      );
      return const Right(null);
    } on DioException catch (e) {
      logger.e("Error updating expense ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get all budgets
  @override
  Future<Either<String, List<BudgetModel>>> getAllBudgets() async {
    try {
      final options = await _getOptions();
      final response = await dio.get(ApiUrl.budgetURL, options: options);
      final budgets =
          (response.data["budgets"] as List)
              .map((e) => BudgetModel.fromJson(e))
              .toList();
      return Right(budgets);
    } on DioException catch (e) {
      logger.e("Error fetching all budgets: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get a budget by ID
  @override
  Future<Either<String, BudgetModel>> getBudgetById(String id) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        ApiUrl.dynamicBudgetURL(id),
        options: options,
      );
      return Right(BudgetModel.fromJson(response.data));
    } on DioException catch (e) {
      logger.e("Error fetching budget by ID ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get a budget with its expenses
  @override
  Future<Either<String, BudgetModel>> getBudgetWithExpenses(String id) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        ApiUrl.dynamicBudgetWithExpensesURL(id),
        options: options,
      );
      print("Budget with expenses: ${response.data}");
      
      return Right(BudgetModel.fromJson(response.data["budget"]));
    } on DioException catch (e) {
      logger.e("Error fetching budget with expenses ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get all expenses
  @override
  Future<Either<String, List<ExpenseModel>>> getAllExpenses() async {
    try {
      final options = await _getOptions();
      final response = await dio.get(ApiUrl.expenseURL, options: options);
      print("All expenses fetched successfully: ${response.data}");
      final expenses =
          (response.data["expenses"] as List).map((e) => ExpenseModel.fromJson(e)).toList();
      return Right(expenses);
    } on DioException catch (e) {
      logger.e("Error fetching all expenses: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get an expense by ID
  @override
  Future<Either<String, ExpenseModel>> getExpenseById(String id) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        ApiUrl.dynamicExpenseURL(id),
        options: options,
      );
      return Right(ExpenseModel.fromJson(response.data));
    } on DioException catch (e) {
      logger.e("Error fetching expense by ID ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }
}
