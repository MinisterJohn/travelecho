import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';



class GetBudgetWithExpensesUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetBudgetWithExpensesUseCase();

  Future<Either<String, BudgetModel>> call(String id) {
    return repository.getBudgetWithExpenses(id);
  }
}

class GetBudgetByIdUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetBudgetByIdUseCase();

  Future<Either<String, BudgetModel>> call(String id) {
    return repository.getBudgetById(id);
  }
}



class GetBudgetsUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetBudgetsUseCase();

  Future<Either<String, List<BudgetModel>>> call() async {
    try {
      return await repository.getAllBudgets();
    } catch (e) {
      return const Left('Failed to fetch budgets');
    }
  }
}



class DeleteBudgetUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  DeleteBudgetUseCase();

  Future<Either<String, void>> call(String id) {
    return repository.deleteBudget(id);
  }
}
