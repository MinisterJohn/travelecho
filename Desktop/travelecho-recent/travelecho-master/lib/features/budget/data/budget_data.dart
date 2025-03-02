import 'package:flutter/material.dart';
import 'package:travelecho/features/budget/data/models/budget_model.dart';

class BudgetsData extends ChangeNotifier {
  List<Budget> allBudgets = [];

  List<Budget> getAllBudgets() {
    print(allBudgets);
    return allBudgets;
  }

  //add new budget
  void addNewBudget(Budget newBudget) {
    // print(newBudgt)
    allBudgets.add(newBudget);
    notifyListeners();
  }

 Budget getBudget(Budget selectedbudget) {
  return allBudgets.firstWhere(
    (budget) => budget.name == selectedbudget.name,
    orElse: () => throw Exception("Budget not found"),
  );
}

  // delete budget
  void deleteBudget(String name) {
    allBudgets.removeWhere((budget) => budget.name == name);
    notifyListeners();
    // allBudgets.remove(BudgetToBeDeleted);
  }
}
