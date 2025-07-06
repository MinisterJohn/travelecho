import 'package:flutter/material.dart';
import '../../../budget_exports.dart';

class AmountRow extends StatelessWidget {
  final BudgetModel updatedBudget;
  final CurrencyInfo currencyInfo;

  const AmountRow({
    super.key,
    required this.updatedBudget,
    required this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
     final symbol =
      currencyInfo.symbol.isNotEmpty
          ? currencyInfo.symbol
          : updatedBudget.currency;
    final spentAmount = BudgetUtils.calculateSpentAmount(
      updatedBudget.expenses,
    );
    final remainingAmount = updatedBudget.plannedAmount - spentAmount;
    print(remainingAmount);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildBudgetInfoCard(
            updatedBudget: updatedBudget,
            title: "Total Budget",
            amount: BudgetUtils.formatAmount(updatedBudget.plannedAmount, symbol),
          ),
          const SizedBox(width: 12),
          buildBudgetInfoCard(
            updatedBudget: updatedBudget,
            title: "Spent",
            amount: BudgetUtils.formatAmount(spentAmount, symbol),
          ),
          const SizedBox(width: 12),
          buildBudgetInfoCard(
            updatedBudget: updatedBudget,
            title: "Remaining",
            amount: BudgetUtils.formatAmount(remainingAmount, symbol),
          ),
        ],
      ),
    );
  }
}

Widget buildBudgetInfoCard({
  required String title,
  required String amount,
  BudgetModel? updatedBudget,
}) { 

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.withOpacity(0.2)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultColor400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
