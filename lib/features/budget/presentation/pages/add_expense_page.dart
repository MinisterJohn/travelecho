import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../budget_exports.dart';

class AddExpensePage extends StatefulWidget {
  final BudgetModel budget;
  final List<CurrencyInfo> mergedCurrencies;

  const AddExpensePage({
    super.key,
    required this.budget,
    required this.mergedCurrencies,
  });

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String selectedCateogry = "";
  bool isSaving = false;

  bool isFormValid() {
    return titleController.text.isNotEmpty &&
        selectedCateogry.isNotEmpty &&
        amountController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar('Add Expense', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpenseForm(
          titleController: titleController,
          amountController: amountController,
          noteController: noteController,
          selectedCategory: selectedCateogry,
          isSaving: isSaving,
          onCategorySelected: (String selectedCategory) {
            print('Selected category: $selectedCategory');
            setState(() => selectedCateogry = selectedCategory);
          },
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Text(
              widget.mergedCurrencies
                  .firstWhere(
                    (currency) => currency.name == widget.budget.currency,
                    orElse:
                        () => CurrencyInfo(
                          name: widget.budget.currency,
                          symbol: '',
                          key: 'unknown',
                        ),
                  )
                  .symbol,
              style: TextStyle(fontSize: FontSize.size28),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  titleController.clear();
                  amountController.clear();
                  noteController.clear();
                  selectedCateogry = "Select Category";
                });
              },
              child: const Text('Reset'),
            ),

            // WidgetsSpacer.verticalSpacer16,
            ElevatedButton(
              onPressed:
                  isSaving || !isFormValid()
                      ? null
                      : () async {
                        setState(() => isSaving = true);

                        final expense = ExpenseParams(
                          budgetId: widget.budget.id,
                          title: titleController.text,
                          plannedAmount:
                              double.tryParse(amountController.text) ?? 0.0,
                          notes: noteController.text,
                          category: selectedCateogry,
                        );
                        print(expense.toJson());
                        context.read<BudgetBloc>().add(
                          CreateExpenseEvent(expense),
                        );
                        setState(() => isSaving = false);

                        AppNavigator.pop(context);
                      },
              child:
                  isSaving
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Expense'),
            ),

            // WidgetsSpacer.verticalSpacer16,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }
}
