import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../budget_exports.dart';

class AddExpensePage extends StatefulWidget {
  final BudgetModel budget;
  final List<CurrencyInfo> mergedCurrencies;
  final ExpenseModel? expense; // Optional parameter for editing an expense

  const AddExpensePage({
    super.key,
    required this.budget,
    required this.mergedCurrencies,
    this.expense,
  });

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController noteController;
  late TextEditingController actualAmountController;
  late XFile? receiptImage;
  String selectedCategory = "Select Category";
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.expense?.title ?? '');
    amountController = TextEditingController(
      text: widget.expense?.plannedAmount?.toString() ?? '',
    );
    actualAmountController = TextEditingController(
      text: widget.expense?.amount.toString() ?? '',
    );
    receiptImage = null;
    noteController = TextEditingController(text: widget.expense?.notes ?? '');
    if (widget.expense != null) {
      selectedCategory = widget.expense!.category; // ✅ prefill if editing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        widget.expense == null ? 'Add Expense' : 'Edit Expense',
        context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<BudgetBloc, BudgetState>(
            listener: (context, state) {
              print(state);
              if (state is SingleBudgetLoaded || state is ExpenseSaved) {
                // ✅ Success
                setState(() => isSaving = false);
                AppNavigator.pop(context);
              } else if (state is BudgetError) {
                // ❌ Failed
                setState(() => isSaving = false);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is BudgetLoading) {
                setState(() => isSaving = true);
              }
            },
            child: Form(
              key: _formKey,
              onChanged: () => setState(() {}),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ExpenseForm(
                titleController: titleController,
                amountController: amountController,
                noteController: noteController,
                actualAmountController: actualAmountController,
                receiptImage: receiptImage,
                selectedCategory: selectedCategory,
                isSaving: isSaving,
                onCategorySelected: (String category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                prefixIcon:
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
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AddExpenseBottomBar(
        onReset: () {
          _formKey.currentState?.reset();
          setState(() {
            titleController.clear();
            amountController.clear();
            noteController.clear();
            actualAmountController.clear();
            selectedCategory = "Select Category";
          });
        },
        onSave: () {
          if (!_formKey.currentState!.validate()) return;

          final expense = ExpenseParams(
            budgetId: widget.budget.id,
            title: titleController.text,
            plannedAmount:
                double.tryParse(amountController.text.replaceAll(',', '')) ??
                0.0,
            actualAmount:
                double.tryParse(
                  actualAmountController.text.replaceAll(',', ''),
                ) ??
                0.0,
            notes: noteController.text,
            receiptFilePath: receiptImage,
            category: selectedCategory,
          );

          if (widget.expense == null) {
            context.read<BudgetBloc>().add(CreateExpenseEvent(expense));
          } else {
            context.read<BudgetBloc>().add(
              UpdateExpenseEvent(widget.expense!.id, expense),
            );
          }
        },

        isSaving: isSaving,
        isFormValid:
            _formKey.currentState?.validate() ??
            false, // now handled by Form validators
        isEdit: widget.expense != null,
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    actualAmountController.dispose();
    super.dispose();
  }
}
