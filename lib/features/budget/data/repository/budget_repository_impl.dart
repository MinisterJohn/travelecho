// import 'package:dartz/dartz.dart';
// import '../../budget_exports.dart';

// class BudgetRepositoryImpl implements BudgetRepository {
//   final BudgetApiService _apiService;
//   final BudgetLocalSource _localSource;

//   BudgetRepositoryImpl({
//     required BudgetApiService apiService,
//     required BudgetLocalSource localSource,
//   })  : _apiService = apiService,
//         _localSource = localSource;

//   @override
//   Future<Either<BudgetFailure, void>> createBudget(Budget budget) async {
//     try {
//       // First try to save locally
//       await _localSource.saveBudget(budget);

//       // Then try to sync with API
//       final result = await _apiService.createBudget(budget);
//       return result;
//     } catch (e) {
//       return const Left(BudgetCreationFailure('Failed to create budget'));
//     }
//   }

//   @override
//   Future<Either<BudgetFailure, void>> updateBudget(Budget budget) async {
//     try {
//       // Update locally first
//       await _localSource.updateBudget(budget);

//       // Then sync with API
//       final result = await _apiService.updateBudget(budget);
//       return result;
//     } catch (e) {
//       return const Left(BudgetUpdateFailure('Failed to update budget'));
//     }
//   }

//   @override
//   Future<Either<BudgetFailure, void>> deleteBudget(String budgetId) async {
//     try {
//       // Delete locally first
//       await _localSource.deleteBudget(budgetId);

//       // Then sync with API
//       final result = await _apiService.deleteBudget(budgetId);
//       return result;
//     } catch (e) {
//       return const Left(BudgetDeletionFailure('Failed to delete budget'));
//     }
//   }

//   @override
//   Future<Either<BudgetFailure, List<Budget>>> getBudgets() async {
//     try {
//       // First try to get from API
//       final apiResult = await _apiService.getBudgets();

//       return apiResult.fold(
//         (failure) async {
//           // If API fails, try local source
//           try {
//             final localBudgets = await _localSource.getBudgets();
//             return Right(localBudgets);
//           } catch (e) {
//             return Left(BudgetFetchFailure('Failed to fetch budgets'));
//           }
//         },
//         (budgets) async {
//           // If API succeeds, update local storage
//           await _localSource.saveBudgets(budgets);
//           return Right(budgets);
//         },
//       );
//     } catch (e) {
//       return const Left(BudgetFetchFailure('Failed to fetch budgets'));
//     }
//   }

//   @override
//   Future<Either<BudgetFailure, Budget>> getBudgetById(String budgetId) async {
//     try {
//       // First try to get from API
//       final apiResult = await _apiService.getBudgetById(budgetId);

//       return apiResult.fold(
//         (failure) async {
//           // If API fails, try local source
//           try {
//             final localBudget = await _localSource.getBudgetById(budgetId);
//             return Right(localBudget);
//           } catch (e) {
//             return Left(BudgetFetchFailure('Failed to fetch budget'));
//           }
//         },
//         (budget) async {
//           // If API succeeds, update local storage
//           await _localSource.saveBudget(budget);
//           return Right(budget);
//         },
//       );
//     } catch (e) {
//       return const Left(BudgetFetchFailure('Failed to fetch budget'));
//     }
//   }
// }
