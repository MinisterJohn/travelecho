import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class CreateExpenseUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  CreateExpenseUseCase();

  Future<Either<String, void>> call(ExpenseModel expense) {
    return repository.createExpense(expense);
  }
}
