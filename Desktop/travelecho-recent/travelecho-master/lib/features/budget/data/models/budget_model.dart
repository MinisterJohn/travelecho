import 'package:flutter/material.dart';
import 'package:travelecho/features/budget/data/models/expense_model.dart';

class Budget extends ChangeNotifier {
  double amount;
  String name;
  bool isForMultipleDestinations;
  List<ExpenseCategorySelected> expenseList;

  List<ExpenseCategorySelected> getExpenses() {
    // print(allBudgets);
    return expenseList;
  }

  void addNewExpense(ExpenseCategorySelected newExpense) {
    expenseList.add(newExpense);
    notifyListeners();
  }

  void removeExpense(String expenseName) {
    expenseList.removeWhere((expense) => expense.title == expenseName);
    notifyListeners();
  }

  // delete expense
  // int getExpenses() {
  //   return expenseList.toList().length;
  //   // expenseList.remove(expenseToBeDeleted);
  // }

  @override
  String toString() {
    return 'Budget(amount: $amount, name: $name, expenseList: ${expenseList.toString()})';
  }

  Budget(
      {required this.amount,
      required this.name,
      this.isForMultipleDestinations = false,
      expenseList})
      : expenseList = expenseList ?? [];
}

// class SubBudget extends Budget {}
