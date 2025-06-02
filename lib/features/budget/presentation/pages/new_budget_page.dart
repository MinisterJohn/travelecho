import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../budget_exports.dart';

class NewBudgetPage extends StatefulWidget {
  final BudgetModel? budget;

  const NewBudgetPage({super.key, this.budget});

  @override
  _NewBudgetPageState createState() => _NewBudgetPageState();
}

class _NewBudgetPageState extends State<NewBudgetPage> {
  late final TextEditingController _budgetNameController;
  late final TextEditingController _plannedAmountController;
  late final TextEditingController _notesController;

  String _selectedCurrency = 'Dollar';
  final List<String> _currencies = ['Dollar', 'Euro', 'Pound', 'Yen'];

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
    final isEditing = widget.budget != null;

    return Scaffold(
      appBar: setAppBar(
        isEditing ? 'Edit Budget' : 'Create New Budget',
        context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _budgetNameController,
                decoration: const InputDecoration(
                  labelText: 'Budget Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _plannedAmountController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                  labelText: 'Planned Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                items:
                    _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Note....',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () async {
                    final budgetName = _budgetNameController.text.trim();
                    final plannedAmount = _plannedAmountController.text.trim();
                    final notes = _notesController.text.trim();

                    if (budgetName.isEmpty || plannedAmount.isEmpty) {
                      DisplayMessage.errorMessage(
                        'Please fill all required fields',
                        context,
                      );
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

                    BudgetModel createdBudget;

                    if (isEditing) {
                      context.read<BudgetBloc>().add(
                        UpdateBudgetEvent(widget.budget!.id, budgetParams),
                      );
                      createdBudget = widget.budget!;
                    } else {
                      // createdBudget = context.read<BudgetBloc>().add(
                      //   CreateBudgetEvent(budgetParams),
                      // );
                    }

                    // AppNavigator.push(
                    //   context,
                    //   AddExpensePage(budget: createdBudget),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Add Expenses'),
                      WidgetsSpacer.horizontalSpacer8,
                      const Icon(LineIcons.plus),
                    ],
                  ),
                ),
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
                  child:
                      state is BudgetLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
