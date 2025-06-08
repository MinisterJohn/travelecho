import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  final String id;
  final String? tripId;
  final String userId;
  final String budgetId;
  final String title;
  final String category; // e.g., Food, Transport, Lodging
  final double? plannedAmount; // optional
  final double amount; // actual spent
  final DateTime date;
  final String? notes;
  final String? receiptImageUrl;

  const ExpenseModel({
    required this.id,
    required this.tripId,
    required this.budgetId,
    required this.title,
    required this.category,
    required this.plannedAmount,
    required this.amount,
    required this.userId,
    required this.date,
    this.notes,
    this.receiptImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'budgetId': budgetId,
      'title': title,
      'category': category,
      'plannedAmount': plannedAmount,
      'amount': amount,
      'userId': userId,
      'date': date.toIso8601String(),
      'notes': notes,
      'receiptImageUrl': receiptImageUrl,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['_id'] ?? "",
      tripId: map['trip'] ?? "",
      budgetId: map['budget'] ?? "",
      title: map['title'] ?? "",
      category: map['category'] ?? "",
      plannedAmount: (map['plannedAmount'] as num?)?.toDouble(),
      amount: (map['actualAmount'] as num?)?.toDouble() ?? 0.0,
      userId: map['user'] ?? "",
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      notes: map['notes'] ?? "",
      receiptImageUrl: map['receiptImageUrl'] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    tripId,
    budgetId,
    title,
    category,
    plannedAmount,
    amount,
    userId,
    date,
    notes,
    receiptImageUrl,
  ];
  @override
  String toString() {
    return 'ExpenseModel(id: $id, tripId: $tripId, budgetId: $budgetId, title: $title, category: $category, plannedAmount: $plannedAmount, amount: $amount, userId: $userId, date: $date, notes: $notes, receiptImageUrl: $receiptImageUrl)';
  }

  ExpenseModel copyWith({
    String? id,
    String? tripId,
    String? budgetId,
    String? title,
    String? category,
    double? plannedAmount,
    double? amount,
    String? userId,
    DateTime? date,
    String? notes,
    String? receiptImageUrl,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      budgetId: budgetId ?? this.budgetId,
      title: title ?? this.title,
      category: category ?? this.category,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      receiptImageUrl: receiptImageUrl ?? this.receiptImageUrl,
    );
  }
}
