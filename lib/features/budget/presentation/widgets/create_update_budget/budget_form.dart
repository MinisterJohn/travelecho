import 'package:flutter/material.dart';
import "../../../budget_exports.dart";
// import 'searchable_dropdown.dart';

class BudgetForm extends StatelessWidget {
  final TextEditingController budgetNameController;
  final TextEditingController plannedAmountController;
  final TextEditingController notesController;
  final List<String> currenciesNames;
  final String selectedCurrency;
  final ValueChanged<String> onCurrencyChanged;
  final CurrencyInfo selectedCurrencyInfo;

  const BudgetForm({
    super.key,
    required this.budgetNameController,
    required this.plannedAmountController,
    required this.notesController,
    required this.currenciesNames,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.selectedCurrencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: budgetNameController,
          decoration: const InputDecoration(
            labelText: 'Budget Name',
            border: OutlineInputBorder(),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        FormattedAmountField(
          controller: plannedAmountController,
          currencySymbol: selectedCurrencyInfo.symbol,
          labelText: "Planned Amount"
        ),
        WidgetsSpacer.verticalSpacer20,
        CurrencySearchableDropdown(
          items: currenciesNames,
          selectedItem: selectedCurrency,
          onChanged: onCurrencyChanged,
          hintText: 'Select Currency',
        ),
        WidgetsSpacer.verticalSpacer20,
        TextField(
          controller: notesController,
          decoration: const InputDecoration(
            labelText: 'Notes',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
