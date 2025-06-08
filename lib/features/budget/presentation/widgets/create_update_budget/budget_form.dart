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
        TextField(
          controller: plannedAmountController,
          decoration: InputDecoration(
            prefixIcon:
                selectedCurrencyInfo.symbol.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        selectedCurrencyInfo.symbol,
                        style: TextStyle(fontSize: FontSize.size28),
                      ),
                    )
                    : const Icon(Icons.attach_money),
            labelText: 'Planned Amount',
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
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
