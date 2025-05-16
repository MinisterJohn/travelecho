import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class DeleteBudgetParams {
  final String id;

  const DeleteBudgetParams({required this.id});
}

class DeleteBudgetUseCase {
  final BudgetRepository _repository;

  DeleteBudgetUseCase({required BudgetRepository repository})
      : _repository = repository;

  Future<Either<BudgetFailure, void>> call(DeleteBudgetParams params) async {
    try {
      return await _repository.deleteBudget(params.id);
    } catch (e) {
      return const Left(BudgetDeletionFailure('Failed to delete budget'));
    }
  }
}
