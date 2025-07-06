import 'package:flutter/material.dart';

class ExpenseCategoryModel {
  final String name;
  final String description;
  final Icon icon;
  final Color? color;

  ExpenseCategoryModel({
    required this.name,
    required this.description,
    required this.icon,
     this.color
  });
}
class ExpenseCategory {
  final String title;
  final String description;
  final String imagePath;
  bool expenseIsAdded;

  ExpenseCategory({
    required this.title,
    required this.description,
    required this.imagePath,
    this.expenseIsAdded = false,
  });
}

class ExpenseCategorySelected {
  final double amount;
  final String title;
  final String description;
  final String imagePath;
  final bool expenseIsAdded;
  final bool showExpenseDropdown;

  ExpenseCategorySelected({
    required this.amount,
    required this.title,
    required this.description,
    required this.imagePath,
    this.expenseIsAdded = false,
    this.showExpenseDropdown = false,
  });
}
