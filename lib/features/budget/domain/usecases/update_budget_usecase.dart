import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class UpdateBudgetParams {
  final String id;
  final String? name;
  final double? amount;
  final bool? isForMultipleDestinations;
  final List<ExpenseCategorySelected>? expenseList;

  const UpdateBudgetParams({
    required this.id,
    this.name,
    this.amount,
    this.isForMultipleDestinations,
    this.expenseList,
  });
}

class UpdateBudgetUseCase {
  final BudgetRepository _repository;

  UpdateBudgetUseCase({required BudgetRepository repository})
      : _repository = repository;

  Future<Either<BudgetFailure, void>> call(UpdateBudgetParams params) async {
    try {
      final currentBudget = await _repository.getBudgetById(params.id);

      return currentBudget.fold(
        (failure) => Left(failure),
        (budget) async {
          final updatedBudget = Budget(
            id: budget.id,
            name: params.name ?? budget.name,
            amount: params.amount ?? budget.amount,
            isForMultipleDestinations: params.isForMultipleDestinations ??
                budget.isForMultipleDestinations,
            expenseList: params.expenseList ?? budget.expenseList,
            createdAt: budget.createdAt,
            updatedAt: DateTime.now(),
          );

          return await _repository.updateBudget(updatedBudget);
        },
      );
    } catch (e) {
      return const Left(BudgetUpdateFailure('Failed to update budget'));
    }
  }
}
