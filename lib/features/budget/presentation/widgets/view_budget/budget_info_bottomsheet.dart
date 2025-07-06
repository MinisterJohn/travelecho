import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';

class BudgetInfoBottomSheet extends StatelessWidget {
  final BudgetModel budget;
  final CurrencyInfo currencyInfo;

  const BudgetInfoBottomSheet({
    super.key,
    required this.budget,
    required this.currencyInfo,
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
              "About ${budget.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            WidgetsSpacer.verticalSpacer16,
            if (budget.notes != null)
              Text(
                budget.notes!,
                style: TextStyle(fontSize: 14, color: AppColors.defaultColor),
              ),
            if (budget.notes != null) WidgetsSpacer.verticalSpacer16,
            _buildInfoRow(
              LineIcons.calendarPlusAlt,
              "Created on:",
              formatDate(budget.createdAt),
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
              formatDate(budget.updatedAt!),
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.moneyBill,
              "Total Budget:",
              BudgetUtils.formatAmount(budget.plannedAmount, currencyInfo.symbol),
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.barChart,
              "Total Planned Expenses:",
              BudgetUtils.formatAmount(
                BudgetUtils.calculatePlannedExpensesAmount(budget.expenses),
               currencyInfo.symbol,
              ),
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
              "Total Spent Expenses:",
              BudgetUtils.formatAmount(
                BudgetUtils.calculateActualSpentAmount(budget.expenses),
                currencyInfo.symbol,
              ),
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.listUl,
              "Total Number of Expenses:",
              "${BudgetUtils.calculateTotalExpenses(budget.expenses)}",
            ),
            WidgetsSpacer.verticalSpacer8,
            Divider(
              height: 2,
              color: AppColors.defaultColor100,
              thickness: 0.5,
            ),
            WidgetsSpacer.verticalSpacer8,
            _buildInfoRow(
              LineIcons.tags,
              "Total Number of Expense Categories:",
              "${BudgetUtils.calculateTotalExpenseCategories(budget.expenses)}",
            ),
          ],
        ),
      ),
    );
  }
}
