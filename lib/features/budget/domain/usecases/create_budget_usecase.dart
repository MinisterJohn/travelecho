import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class BudgetParams {
  final String name;
  final String? notes;
  final double? plannedAmount;
  final String? currency;

  const BudgetParams({
    required this.name,
    this.notes,
    this.plannedAmount,
    this.currency,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'plannedAmount': plannedAmount ?? 0.0,
      'currency': currency,
    };
  }
}

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