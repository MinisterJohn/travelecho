import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class GetBudgetsUseCase {
  final BudgetRepository _repository;

  GetBudgetsUseCase({required BudgetRepository repository})
      : _repository = repository;

  Future<Either<BudgetFailure, List<Budget>>> call() async {
    try {
      return await _repository.getBudgets();
    } catch (e) {
      return const Left(BudgetFetchFailure('Failed to fetch budgets'));
    }
  }
}
