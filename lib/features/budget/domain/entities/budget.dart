class BudgetParams {
  final String name;
  final String? notes;
  final double? plannedAmount;
  final String? currency;

  const BudgetParams({
    required this.name,
    this.notes,
    this.plannedAmount,
    this.currency,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'plannedAmount': plannedAmount ?? 0.0,
      'currency': currency,
    };
  }
}
