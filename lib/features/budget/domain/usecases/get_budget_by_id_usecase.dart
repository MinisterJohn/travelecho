import 'package:dartz/dartz.dart';
import '../../budget_exports.dart';

class GetBudgetByIdUseCase {
  final BudgetRepository repository;

  GetBudgetByIdUseCase(this.repository);

  Future<Either<String, BudgetModel>> call(String id) {
    return repository.getBudgetById(id);
  }
}
