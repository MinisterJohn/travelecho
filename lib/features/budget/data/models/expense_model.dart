class ExpenseCategory {
  final String title;
  final String description;
  final String imagePath;
  bool expenseIsAdded;

  ExpenseCategory({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.expenseIsAdded,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'expenseIsAdded': expenseIsAdded,
    };
  }

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      expenseIsAdded: json['expenseIsAdded'] as bool,
    );
  }
}

class ExpenseCategorySelected extends ExpenseCategory {
  double amount;
  bool showExpenseDropdown;

  @override
  String toString() {
    return 'Expense(amount: $amount, name: $title, description: $description)';
  }

  ExpenseCategorySelected({
    required super.title,
    required super.description,
    required super.imagePath,
    required super.expenseIsAdded,
    required this.amount,
    required this.showExpenseDropdown,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'amount': amount,
      'showExpenseDropdown': showExpenseDropdown,
    };
  }

  factory ExpenseCategorySelected.fromJson(Map<String, dynamic> json) {
    return ExpenseCategorySelected(
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      expenseIsAdded: json['expenseIsAdded'] as bool,
      amount: json['amount'] as double,
      showExpenseDropdown: json['showExpenseDropdown'] as bool,
    );
  }
}
