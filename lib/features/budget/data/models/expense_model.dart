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
      {required String title,
      required String description,
      required String imagePath,
      required bool expenseIsAdded,
      required this.amount,
      required this.showExpenseDropdown})
      : super(
          title: title,
          description: description,
          imagePath: imagePath,
          expenseIsAdded: expenseIsAdded,
        );
}
