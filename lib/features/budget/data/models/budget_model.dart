import 'package:flutter/material.dart';
import 'package:travelecho/features/budget/data/models/expense_model.dart';

class Budget extends ChangeNotifier {
  final String id;
  double amount;
  String name;
  bool isForMultipleDestinations;
  List<ExpenseCategorySelected> expenseList;
  DateTime createdAt;
  DateTime? updatedAt;

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
    return 'Budget(id: $id, amount: $amount, name: $name, expenseList: ${expenseList.toString()})';
  }

  Budget({
    required this.id,
    required this.amount,
    required this.name,
    this.isForMultipleDestinations = false,
    List<ExpenseCategorySelected>? expenseList,
    DateTime? createdAt,
    this.updatedAt,
  })  : expenseList = expenseList ?? [],
        createdAt = createdAt ?? DateTime.now();

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'name': name,
      'isForMultipleDestinations': isForMultipleDestinations,
      'expenseList': expenseList.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'] as String,
      amount: json['amount'] as double,
      name: json['name'] as String,
      isForMultipleDestinations:
          json['isForMultipleDestinations'] as bool? ?? false,
      expenseList: (json['expenseList'] as List?)
          ?.map((e) => ExpenseCategorySelected.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}

// class SubBudget extends Budget {}
