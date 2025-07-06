class ExpenseParams {
  final String budgetId;
  final String title;
  final String category; // e.g., Food, Transport, Lodging
  final double plannedAmount; // optional
  final double? actualAmount; // actual spent
  final dynamic receiptFilePath;
  final String? notes;

  const ExpenseParams({
    required this.budgetId,
    required this.title,
    required this.category,
    required this.plannedAmount,
    this.actualAmount,
    this.receiptFilePath,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'budget': budgetId,
      'title': title,
      'category': category,
      'plannedAmount': plannedAmount,
      'actualAmount': actualAmount ?? 0.0,
      're'
      'notes': notes,
    };
  }
}
