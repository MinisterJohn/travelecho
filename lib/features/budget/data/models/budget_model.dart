import 'package:equatable/equatable.dart';

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
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['_id'] ?? "",
      userId: map['user'] ?? "",
      tripId: map['trip_id'] ?? "",
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
  ];
  @override
  String toString() {
    return 'BudgetModel(id: $id, userId: $userId, tripId: $tripId, plannedAmount: $plannedAmount, spentAmount: $spentAmount, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt, notes: $notes)';
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
    );
  }
}
