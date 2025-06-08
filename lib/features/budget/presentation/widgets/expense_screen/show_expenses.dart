import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../budget_exports.dart';

class ShowExpenses extends StatelessWidget {
  final BudgetModel budget;
  final List<ExpenseModel> expensesData;
  final CurrencyInfo currency;

  const ShowExpenses({
    super.key,
    required this.budget,
    required this.currency,
    required this.expensesData,
  });

  @override
  Widget build(BuildContext context) {
    //   final List<ExpenseModel> expensesData = budget.expenses ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expenses Overview",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        WidgetsSpacer.verticalSpacer20,
        Column(
          spacing: 10,
          children:
              expensesData.map((expense) {
                return BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    return BlocProvider.value(
                      value: sl<BudgetBloc>(),
                      child: BuildExpense(expense: expense, currency: currency),
                    );
                  },
                );
              }).toList(),
        ),
        WidgetsSpacer.verticalSpacer20,
        ElevatedButton(
          onPressed: () {
            AppNavigator.push(
              context,

              MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: sl<BudgetBloc>()),
                  BlocProvider.value(value: sl<CurrencyBloc>()),
                ],
                child: BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    return AddExpensePage(
                      budget: budget,
                      mergedCurrencies:
                          state is MergedCurrencyListLoaded
                              ? state.currencies
                              : [],
                    );
                  },
                ),
              ),
            );
            // Add your logic here
          },

          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 8),
              Text('Add Expense', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
