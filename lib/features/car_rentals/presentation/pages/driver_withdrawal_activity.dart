import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverWithdrawalActivityScreen extends StatelessWidget {
  const DriverWithdrawalActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> withdrawals = [
      {
        "amount": "\$50",
        "date": "Jan 13, 10:30 AM",
        "bank": "GTBank ****6789",
        "ref": "TXN1642059000001",
        "status": "Completed",
      },
      {
        "amount": "\$50",
        "date": "Jan 19, 10:30 AM",
        "bank": "GTBank ****6789",
        "ref": "TXN1642059000001",
        "status": "Completed",
        "extra": "Oct, 28, 2025",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: setAppBar("Activity", context),
      body: Padding(
        padding: WidgetsSpacer.pagePadding,
        child: ListView.builder(
          itemCount: withdrawals.length,
          itemBuilder: (context, index) {
            final withdrawal = withdrawals[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.defaultColor100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Withdrawal",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      WidgetsSpacer.spacer,
                      Text(
                        withdrawal["amount"] ?? "",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      WidgetsSpacer.horizontalSpacer8,
                      Text(
                        withdrawal["status"] ?? "",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  Text(
                    "${withdrawal["date"] ?? ""}\n${withdrawal["bank"] ?? ""}",
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  Row(
                    children: [
                      Text(
                        "Ref: ${withdrawal["ref"] ?? ""}",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      if (withdrawal.containsKey("extra")) ...[
                        WidgetsSpacer.spacer,
                        Text(
                          withdrawal["extra"] ?? "",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
