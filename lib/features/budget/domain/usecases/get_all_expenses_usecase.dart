import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class GetAllExpensesUseCase {
  final BudgetRepository repository;

  GetAllExpensesUseCase(this.repository);

  Future<Either<String, List<ExpenseModel>>> call() {
    return repository.getAllExpenses();
  }
}
