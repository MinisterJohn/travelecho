import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String id;
  final String userId;
  final String title;
  final double plannedAmount;
  final double actualAmount;
  final DateTime startDate;
  final DateTime endDate;

  const Budget({
    required this.id,
    required this.userId,
    required this.title,
    required this.plannedAmount,
    required this.actualAmount,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [id, userId, title, plannedAmount, actualAmount, startDate, endDate];
}
