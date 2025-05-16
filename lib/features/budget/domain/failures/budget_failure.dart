import 'package:equatable/equatable.dart';

abstract class BudgetFailure extends Equatable {
  final String message;

  const BudgetFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BudgetCreationFailure extends BudgetFailure {
  const BudgetCreationFailure(super.message);
}

class BudgetUpdateFailure extends BudgetFailure {
  const BudgetUpdateFailure(super.message);
}

class BudgetDeletionFailure extends BudgetFailure {
  const BudgetDeletionFailure(super.message);
}

class BudgetFetchFailure extends BudgetFailure {
  const BudgetFetchFailure(super.message);
}

class BudgetValidationFailure extends BudgetFailure {
  const BudgetValidationFailure(super.message);
}
