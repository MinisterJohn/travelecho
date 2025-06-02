import 'package:dartz/dartz.dart';
import '../repository/budget_repository.dart';

class DeleteExpenseUseCase {
  final BudgetRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<Either<String, void>> call(String id) {
    return repository.deleteExpense(id);
  }
}
