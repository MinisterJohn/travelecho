import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';

class ExpenseInfoBottomSheet extends StatelessWidget {
  final ExpenseModel expense;
  final CurrencyInfo currency;

  const ExpenseInfoBottomSheet({
    super.key,
    required this.expense,
    required this.currency,
  });

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor300, size: 20),
        WidgetsSpacer.horizontalSpacer8,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(value, style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About ${expense.title}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            WidgetsSpacer.verticalSpacer16,
            if (expense.notes != null)
              Text(
                expense.notes!,
                style: TextStyle(fontSize: 14, color: AppColors.defaultColor),
              ),
            if (expense.notes != null) WidgetsSpacer.verticalSpacer16,
            _buildInfoRow(
              LineIcons.moneyBill,
              "Planned Amount:",
              "${currency.symbol.isNotEmpty ? currency.symbol : currency.key} ${expense.plannedAmount}",
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.wallet,
              "Actual Spent:",
              "${currency.symbol.isNotEmpty ? currency.symbol : currency.key} ${expense.amount}",
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.calendarPlusAlt,
              "Created on:",
              formatDate(expense.createdAt!),
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.calendarCheckAlt,
              "Last Updated on:",
              formatDate(expense.updatedAt!),
            ),
          ],
        ),
      ),
    );
  }
}
