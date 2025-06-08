import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class CreateBudgetUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  CreateBudgetUseCase();

  Future<Either<String, void>> call(BudgetParams budget) {
    return repository.createBudget(budget);
  }
}

class UpdateBudgetUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  UpdateBudgetUseCase();

  Future<Either<String, void>> call(String id, BudgetParams budget) {
    return repository.updateBudget(id, budget);
  }
}

/// get all budgets
class GetAllBudgetsUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetAllBudgetsUseCase();

  Future<Either<String, List<BudgetModel>>> call() {
    return repository.getAllBudgets();
  }
}