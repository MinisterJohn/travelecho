import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../budget_exports.dart';

class ShowBudgets extends StatelessWidget {
  final List<BudgetModel> budgetsData;

  const ShowBudgets({super.key, required this.budgetsData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Budget Overview",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        WidgetsSpacer.verticalSpacer20,
        Column(
          spacing: 10,
          children:
              budgetsData.map((budget) {
                return BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    return BuildBudget(
                      budget: budget,
                      mergedCurrencies:
                          state is MergedCurrencyListLoaded
                              ? state.currencies
                              : [],
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
                    return NewBudgetPage(
                      mergedCurrencyList:
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
              Text('Add New Budget', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
