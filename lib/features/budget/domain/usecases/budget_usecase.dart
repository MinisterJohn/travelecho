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


class DeleteBudgetUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  DeleteBudgetUseCase();

  Future<Either<String, void>> call(String id) {
    return repository.deleteBudget(id);
  }
}



/// get all budgets
class GetAllBudgetsUseCase {
  final BudgetRepository repository = sl<BudgetRepository>();

  GetAllBudgetsUseCase();

  Future<Either<String, List<BudgetModel>>> call({String? sort, required int limit, required int skip}) async {
    try {
      return await repository.getAllBudgets(sort: sort, limit: limit, skip: skip);
    } catch (e) {
      return const Left('Failed to fetch budgets');
    }
  }
}

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

