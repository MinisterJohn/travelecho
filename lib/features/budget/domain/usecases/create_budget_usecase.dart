import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class CreateBudgetParams {
  final String name;
  final double amount;
  final bool isForMultipleDestinations;
  final List<ExpenseCategorySelected>? expenseList;

  const CreateBudgetParams({
    required this.name,
    required this.amount,
    this.isForMultipleDestinations = false,
    this.expenseList,
  });
}

class CreateBudgetUseCase {
  final BudgetRepository _repository;

  CreateBudgetUseCase({required BudgetRepository repository})
      : _repository = repository;

  Future<Either<BudgetFailure, void>> call(CreateBudgetParams params) async {
    try {
      final budget = Budget(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: params.name,
        amount: params.amount,
        isForMultipleDestinations: params.isForMultipleDestinations,
        expenseList: params.expenseList,
      );

      return await _repository.createBudget(budget);
    } catch (e) {
      return const Left(BudgetCreationFailure('Failed to create budget'));
    }
  }
}
