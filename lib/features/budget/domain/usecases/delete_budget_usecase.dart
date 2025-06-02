import 'package:dartz/dartz.dart';
import '../repository/budget_repository.dart';

class DeleteBudgetUseCase {
  final BudgetRepository repository;

  DeleteBudgetUseCase(this.repository);

  Future<Either<String, void>> call(String id) {
    return repository.deleteBudget(id);
  }
}
