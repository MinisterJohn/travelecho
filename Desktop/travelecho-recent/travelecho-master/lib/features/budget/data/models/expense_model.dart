class ExpenseCategory {
  final String title;
  final String description;
  final String imagePath;
  bool expenseIsAdded;

  ExpenseCategory(
      {required this.title,
      required this.description,
      required this.imagePath,
      required this.expenseIsAdded});
}

class ExpenseCategorySelected extends ExpenseCategory {
  double amount;
  bool showExpenseDropdown;

  @override
  String toString() {
    return 'Expense(amount: $amount, name: $title, description: $description)';
  }

  ExpenseCategorySelected(
      {required super.title,
      required super.description,
      required super.imagePath,
      required super.expenseIsAdded,
      required this.amount,
      required this.showExpenseDropdown});
}
