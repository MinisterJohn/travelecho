import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../budget_exports.dart';

class NewBudgetPage extends StatefulWidget {
  final BudgetModel? budget;
  final List<CurrencyInfo> mergedCurrencyList;

  const NewBudgetPage({
    super.key,
    this.budget,
    required this.mergedCurrencyList,
  });

  @override
  _NewBudgetPageState createState() => _NewBudgetPageState();
}

class _NewBudgetPageState extends State<NewBudgetPage> {
  late final TextEditingController _budgetNameController;
  late final TextEditingController _plannedAmountController;
  late final TextEditingController _notesController;

  final List<CurrencyInfo> _currencies = [];
  final List<String> _currenciesNames = [];
  String _selectedCurrency = 'Dollar';
  CurrencyInfo selectedCurrencyInfo = CurrencyInfo(
    name: 'Dollar',
    symbol: '\$',
    key: 'USD',
  );

  @override
  void initState() {
    super.initState();
    print(widget.budget);
    _budgetNameController = TextEditingController(
      text: widget.budget != null ? widget.budget!.name : '',
    );
    _plannedAmountController = TextEditingController(
      text:
          widget.budget != null ? widget.budget!.plannedAmount.toString() : '',
    );
    _notesController = TextEditingController(
      text: widget.budget != null ? widget.budget!.notes : '',
    );
    _selectedCurrency =
        widget.budget != null ? widget.budget!.currency : 'Dollar';
    print("hello");
    _fetchCurrencies(context);
  }

  Future<void> _fetchCurrencies(BuildContext context) async {
    // context.read<CurrencyBloc>().add(
    //   MergedCurrencyListRequested(context: context),
    // );

    print("Current state: ");
    // if (state is MergedCurrencyListLoaded) {
    setState(() {
      _currencies.clear();
      _currencies.addAll(widget.mergedCurrencyList);

      final availableNames = _currencies.map((c) => c.name).toSet().toList();
      _currenciesNames.clear();
      _currenciesNames.addAll(availableNames);
      print("Available names: $availableNames");
      // Preserve the selected currency if valid
      if (!_currenciesNames.contains(_selectedCurrency)) {
        _selectedCurrency = _currencies.first.name;
      }

      // Update the symbol for the selected currency
      selectedCurrencyInfo = _currencies.firstWhere(
        (c) => c.name == _selectedCurrency,
        orElse: () => _currencies.first,
      );
    });
    // } else if (state is CurrencyError) {
    //   DisplayMessage.errorMessage(state.message, context);
    // }
  }

  @override
  void dispose() {
    _budgetNameController.dispose();
    _plannedAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void handleSave() {
    final budgetName = _budgetNameController.text.trim();
    final plannedAmount = _plannedAmountController.text.trim();
    final notes = _notesController.text.trim();

    if (budgetName.isEmpty || plannedAmount.isEmpty) {
      DisplayMessage.errorMessage('Please fill all required fields', context);
      return;
    }

    final parsedAmount = double.tryParse(plannedAmount);
    if (parsedAmount == null || parsedAmount <= 0) {
      DisplayMessage.errorMessage(
        'Please enter a valid planned amount',
        context,
      );
      return;
    }

    final budgetParams = BudgetParams(
      name: budgetName,
      plannedAmount: parsedAmount,
      notes: notes,
      currency: _selectedCurrency,
    );

    final isEditing = widget.budget != null;

    if (isEditing) {
      print(widget.budget);
      context.read<BudgetBloc>().add(
        UpdateBudgetEvent(widget.budget!.id, budgetParams),
      );
      DisplayMessage.successMessage(
        'Budget "$budgetName" updated successfully!',
        context,
      );
    } else {
      context.read<BudgetBloc>().add(CreateBudgetEvent(budgetParams));
      DisplayMessage.successMessage(
        'Budget "$budgetName" created successfully!',
        context,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
        widget.budget != null ? 'Edit Budget' : 'Create Budget',
        context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BudgetForm(
                budgetNameController: _budgetNameController,
                plannedAmountController: _plannedAmountController,
                notesController: _notesController,
                currenciesNames: _currenciesNames,
                selectedCurrency: _selectedCurrency,
                onCurrencyChanged: (String newValue) {
                  setState(() {
                    _selectedCurrency = newValue;
                  });
                },
                selectedCurrencyInfo: selectedCurrencyInfo,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: const Text("Reset")),
            BlocBuilder<BudgetBloc, BudgetState>(
              builder: (BuildContext context, BudgetState state) {
                if (state is BudgetLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: state is BudgetLoading ? null : handleSave,
                  child: const Text("Save"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
