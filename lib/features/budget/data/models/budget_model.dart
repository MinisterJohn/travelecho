import 'package:equatable/equatable.dart';
import "../../budget_exports.dart";

class BudgetModel extends Equatable {
  final String id; // Unique ID for this budget record
  final String userId;
  final String name;
  final String? tripId;
  final double plannedAmount; // Total budget for the trip
  final double spentAmount; // Total spent so far
  final String currency; // e.g., USD, EUR, NGN
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final List<ExpenseModel>? expenses;

  const BudgetModel({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.name,
    required this.plannedAmount,
    required this.spentAmount,
    required this.currency,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    this.expenses,
  });

  double get remaining => plannedAmount - spentAmount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tripId': tripId,
      'name': name,
      'plannedAmount': plannedAmount,
      'spentAmount': spentAmount,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
      'expenses': expenses,
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['_id'] ?? "",
      userId: map['user'] ?? "",
      tripId: map['trip'] ?? "",
      name: map['name'] ?? "",
      plannedAmount:
          map["plannedAmount"] != null
              ? (map['plannedAmount'] as num).toDouble()
              : 0.0,
      spentAmount:
          map["spentAmount"] != null
              ? (map['spentAmount'] as num).toDouble()
              : 0.0,
      currency: map['currency'] ?? "",
      createdAt:
          map['createdAt'] != null
              ? DateTime.parse(map['createdAt'])
              : DateTime.now(),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.parse(map['updatedAt'])
              : DateTime.now(),
      notes: map['notes'] ?? "",
      expenses:
          map.containsKey('expenses') && map['expenses'] is List
              ? List<ExpenseModel>.from(
                (map['expenses'] as List).map(
                  (expense) => ExpenseModel.fromJson(expense),
                ),
              )
              : [],
    );
  }
  @override
  List<Object?> get props => [
    id,
    userId,
    tripId,
    plannedAmount,
    spentAmount,
    currency,
    createdAt,
    updatedAt,
    notes,
    expenses,
  ];
  @override
  String toString() {
    return 'BudgetModel(id: $id, userId: $userId, tripId: $tripId, plannedAmount: $plannedAmount, spentAmount: $spentAmount, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt, notes: $notes, expenses: $expenses)';
  }

  BudgetModel copyWith({
    String? id,
    String? userId,
    String? tripId,
    String? name,
    double? plannedAmount,
    double? spentAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    List<ExpenseModel>? expenses,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tripId: tripId ?? this.tripId,
      name: name ?? this.name,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      expenses: expenses!.isNotEmpty ? expenses : this.expenses,
    );
  }
}
