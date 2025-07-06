import 'package:flutter/material.dart';

class TravelDocumentExpiryLabel extends StatelessWidget {
  final DateTime expiryDate;
  final bool isExpired;

  const TravelDocumentExpiryLabel({
    super.key,
    required this.expiryDate,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    final nowUtc = DateTime.now().toUtc();
    final expiryUtc = expiryDate.toUtc();
    final isToday =
        expiryUtc.year == nowUtc.year &&
        expiryUtc.month == nowUtc.month &&
        expiryUtc.day == nowUtc.day;

    final daysToExpiry = expiryUtc.difference(nowUtc).inDays;
    final isExpiringSoon = daysToExpiry >= 0 && daysToExpiry <= 5;

    Color expiryColor;
    if (isToday || daysToExpiry == 0) {
      expiryColor = Colors.amber[900]!;
    } else if (isExpiringSoon) {
      expiryColor = Colors.amber[600]!;
    } else if (isExpired) {
      expiryColor = Colors.red;
    } else {
      expiryColor = Theme.of(context).primaryColor;
    }

    if (isExpiringSoon && !isExpired) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: expiryColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          daysToExpiry == 0
              ? "EXPIRES TODAY"
              : "EXPIRES IN $daysToExpiry DAY${daysToExpiry == 1 ? '' : 'S'}",
          style: TextStyle(color: expiryColor, fontWeight: FontWeight.bold),
        ),
      );
    }
    if (isExpired) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: expiryColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          "EXPIRED",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
